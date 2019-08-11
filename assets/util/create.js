const fse = require('fs-extra');
const fs = require('fs');
const uuidv4 = require('uuid/v4');

const updateRouterFile = (routerFilePath, fullType, fullSlug, fullUnderscoreSlug) => {
  fs.readFile(routerFilePath, 'utf8', function (err,data) {
    if (err) return console.log(err);
    const underscore = `${fullType}_${fullUnderscoreSlug}`;
    const fullTypeEnd = `${fullType.toUpperCase()} END`;

    const regex = `# ${fullTypeEnd}`;
    var result = data.replace(new RegExp(regex, 'gi'),
    `get \"/${fullSlug}\", PageController, :${underscore}\n    # ${fullTypeEnd}`);

    fs.writeFile(routerFilePath, result, 'utf8', function (err) {
       if (err) return console.log(err);
    });
  });
}

const updateFetchAccessFile = (fetchAccessFilePath, fullType, fullSlug, fullUnderscoreSlug) => {
  fs.readFile(fetchAccessFilePath, 'utf8', function (err,data) {
    if (err) return console.log(err);
    const underscore = `${fullType}_${fullUnderscoreSlug}`;
    const fullTypeEnd = `${fullType.toUpperCase()} END`;

    const regex = `# ${fullTypeEnd}`;
    var result = data.replace(new RegExp(regex, 'gi'),
    `:${underscore} -> [:meditations]\n      # ${fullTypeEnd}`);

    fs.writeFile(fetchAccessFilePath, result, 'utf8', function (err) {
       if (err) return console.log(err);
    });
  });
}

const updatePageAPIFile = (fetchAccessFilePath, fullType, fullSlug, fullUnderscoreSlug) => {
  fs.readFile(fetchAccessFilePath, 'utf8', function (err,data) {
    if (err) return console.log(err);
    const underscore = `${fullType}_${fullUnderscoreSlug}`;
    const fullTypeEnd = `${fullType.toUpperCase()} END`;

    const regex = `# ${fullTypeEnd}`;
    var result = data.replace(new RegExp(regex, 'gi'),
    `def ${underscore}(client), do: get(client, "/${underscore}/index.json")\n  # ${fullTypeEnd}`);

    fs.writeFile(fetchAccessFilePath, result, 'utf8', function (err) {
       if (err) return console.log(err);
    });
  });
}

const updatePageControllerFile = (pageControllerFilePath, fullType, fullSlug, fullUnderscoreSlug) => {
  fs.readFile(pageControllerFilePath, 'utf8', function (err,data) {
    if (err) return console.log(err);
    const underscore = `${fullType}_${fullUnderscoreSlug}`;
    const fullTypeEnd = `${fullType.toUpperCase()} END`;

    const regex = `# ${fullTypeEnd}`;
    var result = data.replace(new RegExp(regex, 'gi'),
    `def ${underscore}(conn, _params), do: Fetch.fetch_page(conn, NfdWeb.PageView, :${underscore}, "general.html", FetchAccess.fetch_access_array(:${underscore}))\n  # ${fullTypeEnd}`);

    fs.writeFile(pageControllerFilePath, result, 'utf8', function (err) {
       if (err) return console.log(err);
    });
  });
}

const updateSitemapsFile = (pageControllerFilePath, fullType, fullSlug, fullUnderscoreSlug) => {
  fs.readFile(pageControllerFilePath, 'utf8', function (err,data) {
    if (err) return console.log(err);
    const underscore = `${fullType}_${fullUnderscoreSlug}`;
    const fullTypeEnd = `${fullType.toUpperCase()} END`;

    const regex = `# ${fullTypeEnd}`;
    var result = data.replace(new RegExp(regex, 'gi'),
    `add Helpers.page_path(Endpoint, :${underscore}), priority: 0.5, changefreq: "weekly", expires: nil\n        # ${fullTypeEnd}`);

    fs.writeFile(pageControllerFilePath, result, 'utf8', function (err) {
       if (err) return console.log(err);
    });
  });
}

const createLink = () => {
  // ex. npm run create misc blogs
  const fullType = process.argv[2];
  const fullSlug = process.argv[3];
  const fullUnderscoreSlug = fullSlug.replace(/-/gi, '_');

  console.log(fullType, fullSlug, fullUnderscoreSlug);

  // Create router.ex entry
  const routerFilePath = `../lib/nfd_web/router.ex`;
  updateRouterFile(routerFilePath, fullType, fullSlug, fullUnderscoreSlug);

  // Create fetch_access.ex entry
  const fetch_accessFilePath = `../lib/nfd_web/fetch_access.ex`;
  updateFetchAccessFile(fetch_accessFilePath, fullType, fullSlug, fullUnderscoreSlug);

  // Create page_api.ex entry
  const page_apiFilePath = `../lib/nfd/api/page_api.ex`;
  updatePageAPIFile(page_apiFilePath, fullType, fullSlug, fullUnderscoreSlug);

  // Create page_controller.ex entry
  const page_controllerFilePath = `../lib/nfd_web/controllers/page_controller.ex`;
  updatePageControllerFile(page_controllerFilePath, fullType, fullSlug, fullUnderscoreSlug);

  // // Create sitemaps.ex entry
  const sitemapsFilePath = `../lib/nfd/sitemaps.ex`;
  updateSitemapsFile(sitemapsFilePath, fullType, fullSlug, fullUnderscoreSlug);
};

createLink();
