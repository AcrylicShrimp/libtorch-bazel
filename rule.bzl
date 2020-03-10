def _impl(ctx):
    ctx.download_and_extract(url = ctx.attr.url, output = "libtorch", sha256 = ctx.attr.sha256, stripPrefix = "libtorch")

libtorch = repository_rule(implementation = _impl)
