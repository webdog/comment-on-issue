#!/usr/bin/env python3

import os
import argparse
import github3
import json

# The event payload lives in this file in Docker"
jsonf = open('/github/workflow/event.json', 'r')

parser = argparse.ArgumentParser()
comment = parser.add_argument("comment", help="your comment string", type=str)
args = parser.parse_args()

comment_data = args.comment

jwt = os.environ.get('GITHUB_TOKEN')
username = os.environ.get('GITHUB_ACTOR')

json_data = json.load(jsonf)
gh = github3.login(username=username, token=jwt)

if json_data['action'] == "created":
    issue_num = json_data['issue']['number']
    user = json_data['user']['login']
    repo = json_data['repository']['name']
    issue = gh.issue(user, repo, issue_num)
    issue.create_comment(
        f"# {args} \
        ![octocat](https://octodex.github.com/images/justicetocat.jpg)"
    )
