#!/bin/bash

# Check if the current directory is a Git repository
if [ ! -d ".git" ]; then
    echo "The current directory is not a Git repository. Initializing..."
    git init
    echo "Initialized as a new Git repository."
    # Optionally add a remote if needed, e.g., git remote add origin <repo-url>
fi

# Fetch updates from the remote (only if a remote is set)
git fetch origin 2>/dev/null || echo "No remote repository to fetch from."

# Create and push branches
for branch in qa stage prod; do
    git checkout -b "$branch" master 2>/dev/null || git checkout "$branch"
    
    # Check if remote exists before pushing
    git push -u origin "$branch" 2>/dev/null || echo "Branch '$branch' created locally, but no remote to push to."
    
    git checkout master
done

echo "Created standard branches successfully."
