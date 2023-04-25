function _flow_rebase() {
	git fetch origin
	
	local branch=$(_flow_branch)
	local upstream

	if [[ "$branch" == "master" ]] || [[ "$branch" == hotfix* ]] then
		upstream=master
	else
		upstream=develop
	fi

	git rebase --autostash origin/$upstream
}

function _flow_draft() {
	git fetch origin --quiet
	
    if (( ${+2} )); then
        local last_tag=$(git describe --tags --abbrev=0 origin/master --match "$2-*")
    else 
        local last_tag=$(git describe --tags --abbrev=0 origin/master)
    fi

    local last_version
    local prefix

    [[ $last_tag =~ '([a-zA-Z\-]*)([0-9]+\.[0-9]+\.[0-9]+)' ]] \
        && prefix=$match[1] \
        && last_version=$match[2]

	echo "################################################"
	echo "#       Last tag: $last_tag"
	echo "#   Last version: $last_version"
	echo "################################################"

	local last_major=$(echo $last_version | cut -d '.' -f 1)
	local last_minor=$(echo $last_version | cut -d '.' -f 2)
	local last_patch=$(echo $last_version | cut -d '.' -f 3)

    last_major=${last_major:-0}
    last_minor=${last_minor:-0}
    last_patch=${last_patch:-0}

	local upstream
	local new_tag
    local new_branch

	if [[ "$1" == "hotfix" ]] then
		upstream="master"
		new_tag="$prefix$last_major.$last_minor.$(( $last_patch + 1 ))"
	else
		upstream="develop"
		new_tag="$prefix$last_major.$(( $last_minor + 1 )).0"
	fi

    new_branch="$1/$new_tag"

	echo "#        New tag: $new_tag"
	echo "#       Upstream: $upstream"	
    echo "# Working branch: $new_branch"
    echo "################################################"

	git checkout origin/$upstream -b $new_branch --quiet
}

function _flow_audit() {
    local branch=$(_flow_branch)

    if [[ "$branch" != release* ]] then
        echo "Auditing is for release branches only."
        return 1
    fi

    local behind=$(git rev-list HEAD..origin/master --count --no-merges)

    if (( $behind > 0 )) then
        echo "This release is $behind commits behind master!"
        echo "Branch should be rebased."
        echo "Audit might not be accurate until this branch is rebased."
        echo ""
    fi

    echo "Finishing this release will add these commits to master:"
    git --no-pager log --no-merges --oneline HEAD ^origin/master
}

function _flow_finish() {
#    if ! [[ -x "$(git diff-index --quiet HEAD)" ]]; then
#        echo "Dirty HEAD - Aborting"
#        return 1
#    fi

    _flow_rebase

	local branch=$(_flow_branch)
	
	if [[ "$branch" == hotfix* ]] || [[ "$branch" == release* ]] then
		local tag_name=$(echo $branch | cut -d '/' -f 2)

        echo "###########################################"
        echo "# Finishing with tag: $tag_name"
        echo "###########################################"

		git checkout master --quiet &&
            git rebase --autostash origin/master --quiet &&
		    git merge --no-ff --no-edit $branch --quiet &&
            echo "# Merged into master"

		git tag -m $tag_name -a $tag_name &&
            echo "# Tagged as $tag_name"

		git checkout develop --quiet &&
            git rebase --autostash origin/develop --quiet &&
    		git merge --no-ff --no-edit $branch --quiet &&
            echo "# Back-Merged into develop"

        echo "###########################################"
        echo "# Finished $branch => $tag_name"
        echo "###########################################"
	else
		git checkout develop -q
		git rebase --autostash origin/develop -q
		git merge --ff-only $branch -q
	fi
}

function _flow_branch() {
	echo $(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
}

function _flow_feat() {
	git fetch origin
	git checkout origin/develop -b feature/$1
}

function _flow_push() {
    if [[ "$1" == "hotfix" ]] || [[ "$1" == "release" ]] then
        git push origin master:master
        git push --tags
    fi
    git push origin develop:develop
}

function _flow_prune() {
    "_flow_prune_$1"
}

function _flow_prune_local() {
    for branch in $(git branch --merged origin/master | grep -v master | grep -v develop); do
        read -q "DEL?Delete $branch? [Y/n] "
        case "$DEL" in
            y)
                echo ""
                git branch -D $branch
                ;;
            n)
                echo "\nSkipped"
                ;;
        esac
    done
}

function _flow_prune_remote() {
    declare -a branches=(
        $(git for-each-ref refs/remotes/origin \
            --format=' %(authoremail) %09 %(refname:lstrip=3)' \
            --sort=authorname \
            --merged origin/master \
            | grep -v master \
            | grep $(git config --get user.email) \
            | cut -f 2
        )
    )

    for branch in "${branches[@]}"; do
        read -q "DEL?Delete $branch? [Y/n] "
        case "$DEL" in
            y)
                echo ""
                git push origin :$branch
                ;;
            n)
                echo "\nSkipped"
                ;;
        esac
    done
}

function _flow_test() {
}

function flow() {
	"_flow_$1" ${@:2}
}

