# ProjectTaskApi

The AL extension from **Part 6** of my Business Central series on Medium:
[AL Development in Business Central Part 6: API Pages, OData, and Bound Actions](https://medium.com/@albertassaad/al-development-in-business-central-part-6-api-pages-odata-and-bound-actions-8da530048da2)

It exposes the Project Task table from Part 4 as a REST endpoint, and adds a bound
action that lets an external caller run the Complete Task logic over HTTP without
knowing what that logic does.

## What's in here

| File | What it is |
|---|---|
| `Pag50200.ProjectTasksAPI.al` | The API page: the five route properties, `ODataKeyFields = SystemId`, and the `[ServiceEnabled] completeTask` bound action |
| `app.json` | ID range 50200–50249, and the dependency on the Part 4 app |
| `.vscode/launch.json` | The container config used in the article: server `bcserver`, instance `BC`, tenant `default` |

## You need Part 4 as well

This extension does not compile on its own. It depends on the `Example` app from
Part 4, which owns the Project Task table:

**https://github.com/AlbertAssaad/TaskProject**

Publish that one to your container first, then run `AL: Download Symbols` here.

Read the `id`, `name` and `publisher` out of your own copy of that project's
`app.json` and put them in the `dependencies` block in this project's `app.json`.
Mine will not match yours, and a mismatch fails at symbol download with an error
that sounds like the app doesn't exist.

## The endpoint

    http://<container>:7048/BC/api/albertassaad/projectMgmt/v1.0/companies({id})/projectTasks?tenant=default

Two things worth knowing before your first call:

- Web service calls authenticate with the user's **Web Service Access Key**, not
  the password you sign into the web client with.
- BcContainerHelper containers are multitenant, so `?tenant=default` belongs on
  every URL. Leave it off and you get a 401 that looks like a credentials problem.

## Not committed

`.alpackages/` (around 60 MB of Microsoft symbol packages; run `AL: Download
Symbols` to get your own), the compiled `.app` file, and `.vscode/rad.json`,
which VS Code rewrites on every publish.
