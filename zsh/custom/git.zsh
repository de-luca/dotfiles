function ckout() {
	git checkout $(git for-each-ref --format='%(refname:short)' 'refs/heads' | fzf)
}

function stashl() {
	git show $(git stash list | fzf | cut -d ':' -f 1)
}

function stash_apply() {
    git stash apply $(git stash list | fzf | cut -d ':' -f 1)
}

function reflog() {
	git show $(git reflog | fzf | cut -d ' ' -f 1)
}

function greport() {
    local merged_branches=$(git for-each-ref --merged origin/master --format='%(refname:short)' 'refs/heads')
    local unmerged_branches=$(git for-each-ref --no-merged origin/master --format='%(refname:short)' 'refs/heads')
    local merged_branches_count=$(echo $merged_branches | wc -l)
    local unmerged_branches_count=$(echo $unmerged_branches | wc -l)
    local branches_count=$(( $merged_branches_count + $unmerged_branches_count ))

    echo "#####################################################################"
    echo "# GIT analyse report"
    echo "#####################################################################"
    echo "# Branches: $branches_count"
    echo "# Merged in origin/master: $merged_branches_count"
    echo "# Not merged in origin/master: $unmerged_branches_count"
    echo "# $(( $merged_branches_count/$branches_count )) %"
    echo "#####################################################################"
}
