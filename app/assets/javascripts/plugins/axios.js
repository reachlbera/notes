/* axios v0.12.0 | (c) 2016 by Matt Zabriskie */
!function(e, t) {
    "object" == typeof exports && "object" == typeof module ? module.exports = t() : "function" == typeof define && define.amd ? define([], t) : "object" == typeof exports ? exports.axios = t() : e.axios = t()
}(this, function() {
    return function(e) {
        function t(n) {
            if (r[n])
                return r[n].exports;
            var o = r[n] = {
                exports: {},
                id: n,
                loaded: !1
            };
            return e[n].call(o.exports, o, o.exports, t),
            o.loaded = !0,
            o.exports
        }
        var r = {};
        return t.m = e,
        t.c = r,
        t.p = "",
        t(0)
    }([function(e, t, r) {
        e.exports = r(1)
    }
    , function(e, t, r) {
        "use strict";
        function n(e) {
            this.defaults = i.merge({}, e),
            this.interceptors = {
                request: new u,
                response: new u
            }
        }
        var o = r(2)
          , i = r(3)
          , s = r(5)
          , u = r(14)
          , a = r(15)
          , c = r(16)
          , f = r(17)
          , p = r(9);
        n.prototype.request = function(e) {
            "string" == typeof e && (e = i.merge({
                url: arguments[0]
            }, arguments[1])),
            e = i.merge(o, this.defaults, {
                method: "get"
            }, e),
            e.baseURL && !a(e.url) && (e.url = c(e.baseURL, e.url)),
            e.withCredentials = e.withCredentials || this.defaults.withCredentials,
            e.data = p(e.data, e.headers, e.transformRequest),
            e.headers = i.merge(e.headers.common || {}, e.headers[e.method] || {}, e.headers || {}),
            i.forEach(["delete", "get", "head", "post", "put", "patch", "common"], function(t) {
                delete e.headers[t]
            });
            var t = [s, void 0]
              , r = Promise.resolve(e);
            for (this.interceptors.request.forEach(function(e) {
                t.unshift(e.fulfilled, e.rejected)
            }),
            this.interceptors.response.forEach(function(e) {
                t.push(e.fulfilled, e.rejected)
            }); t.length; )
                r = r.then(t.shift(), t.shift());
            return r
        }
        ;
        var d = new n(o)
          , l = e.exports = f(n.prototype.request, d);
        l.request = f(n.prototype.request, d),
        l.Axios = n,
        l.defaults = d.defaults,
        l.interceptors = d.interceptors,
        l.create = function(e) {
            return new n(e)
        }
        ,
        l.all = function(e) {
            return Promise.all(e)
        }
        ,
        l.spread = r(18),
        i.forEach(["delete", "get", "head"], function(e) {
            n.prototype[e] = function(t, r) {
                return this.request(i.merge(r || {}, {
                    method: e,
                    url: t
                }))
            }
            ,
            l[e] = f(n.prototype[e], d)
        }),
        i.forEach(["post", "put", "patch"], function(e) {
            n.prototype[e] = function(t, r, n) {
                return this.request(i.merge(n || {}, {
                    method: e,
                    url: t,
                    data: r
                }))
            }
            ,
            l[e] = f(n.prototype[e], d)
        })
    }
    , function(e, t, r) {
        "use strict";
        function n(e, t) {
            !o.isUndefined(e) && o.isUndefined(e["Content-Type"]) && (e["Content-Type"] = t)
        }
        var o = r(3)
          , i = r(4)
          , s = /^\)\]\}',?\n/
          , u = {
            "Content-Type": "application/x-www-form-urlencoded"
        };
        e.exports = {
            transformRequest: [function(e, t) {
                return i(t, "Content-Type"),
                o.isFormData(e) || o.isArrayBuffer(e) || o.isStream(e) || o.isFile(e) || o.isBlob(e) ? e : o.isArrayBufferView(e) ? e.buffer : o.isURLSearchParams(e) ? (n(t, "application/x-www-form-urlencoded;charset=utf-8"),
                e.toString()) : o.isObject(e) ? (n(t, "application/json;charset=utf-8"),
                JSON.stringify(e)) : e
            }
            ],
            transformResponse: [function(e) {
                if ("string" == typeof e) {
                    e = e.replace(s, "");
                    try {
                        e = JSON.parse(e)
                    } catch (t) {}
                }
                return e
            }
            ],
            headers: {
                common: {
                    Accept: "application/json, text/plain, */*"
                },
                patch: o.merge(u),
                post: o.merge(u),
                put: o.merge(u)
            },
            timeout: 0,
            xsrfCookieName: "XSRF-TOKEN",
            xsrfHeaderName: "X-XSRF-TOKEN",
            maxContentLength: -1,
            validateStatus: function(e) {
                return e >= 200 && 300 > e
            }
        }
    }
    , function(e, t) {
        "use strict";
        function r(e) {
            return "[object Array]" === x.call(e)
        }
        function n(e) {
            return "[object ArrayBuffer]" === x.call(e)
        }
        function o(e) {
            return "undefined" != typeof FormData && e instanceof FormData
        }
        function i(e) {
            var t;
            return t = "undefined" != typeof ArrayBuffer && ArrayBuffer.isView ? ArrayBuffer.isView(e) : e && e.buffer && e.buffer instanceof ArrayBuffer
        }
        function s(e) {
            return "string" == typeof e
        }
        function u(e) {
            return "number" == typeof e
        }
        function a(e) {
            return "undefined" == typeof e
        }
        function c(e) {
            return null  !== e && "object" == typeof e
        }
        function f(e) {
            return "[object Date]" === x.call(e)
        }
        function p(e) {
            return "[object File]" === x.call(e)
        }
        function d(e) {
            return "[object Blob]" === x.call(e)
        }
        function l(e) {
            return "[object Function]" === x.call(e)
        }
        function h(e) {
            return c(e) && l(e.pipe)
        }
        function m(e) {
            return "undefined" != typeof URLSearchParams && e instanceof URLSearchParams
        }
        function y(e) {
            return e.replace(/^\s*/, "").replace(/\s*$/, "")
        }
        function w() {
            return "undefined" != typeof window && "undefined" != typeof document && "function" == typeof document.createElement
        }
        function g(e, t) {
            if (null  !== e && "undefined" != typeof e)
                if ("object" == typeof e || r(e) || (e = [e]),
                r(e))
                    for (var n = 0, o = e.length; o > n; n++)
                        t.call(null , e[n], n, e);
                else
                    for (var i in e)
                        e.hasOwnProperty(i) && t.call(null , e[i], i, e)
        }
        function v() {
            function e(e, r) {
                "object" == typeof t[r] && "object" == typeof e ? t[r] = v(t[r], e) : t[r] = e
            }
            for (var t = {}, r = 0, n = arguments.length; n > r; r++)
                g(arguments[r], e);
            return t
        }
        var x = Object.prototype.toString;
        e.exports = {
            isArray: r,
            isArrayBuffer: n,
            isFormData: o,
            isArrayBufferView: i,
            isString: s,
            isNumber: u,
            isObject: c,
            isUndefined: a,
            isDate: f,
            isFile: p,
            isBlob: d,
            isFunction: l,
            isStream: h,
            isURLSearchParams: m,
            isStandardBrowserEnv: w,
            forEach: g,
            merge: v,
            trim: y
        }
    }
    , function(e, t, r) {
        "use strict";
        var n = r(3);
        e.exports = function(e, t) {
            n.forEach(e, function(r, n) {
                n !== t && n.toUpperCase() === t.toUpperCase() && (e[t] = r,
                delete e[n])
            })
        }
    }
    , function(e, t, r) {
        "use strict";
        e.exports = function(e) {
            return new Promise(function(t, n) {
                try {
                    var o;
                    "function" == typeof e.adapter ? o = e.adapter : "undefined" != typeof XMLHttpRequest ? o = r(6) : "undefined" != typeof process && (o = r(6)),
                    "function" == typeof o && o(t, n, e)
                } catch (i) {
                    n(i)
                }
            }
            )
        }
    }
    , function(e, t, r) {
        "use strict";
        var n = r(3)
          , o = r(7)
          , i = r(8)
          , s = r(9)
          , u = r(10)
          , a = "undefined" != typeof window && window.btoa || r(11)
          , c = r(12);
        e.exports = function(e, t, f) {
            var p = f.data
              , d = f.headers;
            n.isFormData(p) && delete d["Content-Type"];
            var l = new XMLHttpRequest
              , h = "onreadystatechange"
              , m = !1;
            if ("undefined" == typeof window || !window.XDomainRequest || "withCredentials" in l || u(f.url) || (l = new window.XDomainRequest,
            h = "onload",
            m = !0,
            l.onprogress = function() {}
            ,
            l.ontimeout = function() {}
            ),
            f.auth) {
                var y = f.auth.username || ""
                  , w = f.auth.password || "";
                d.Authorization = "Basic " + a(y + ":" + w)
            }
            if (l.open(f.method.toUpperCase(), o(f.url, f.params, f.paramsSerializer), !0),
            l.timeout = f.timeout,
            l[h] = function() {
                if (l && (4 === l.readyState || m) && 0 !== l.status) {
                    var r = "getAllResponseHeaders" in l ? i(l.getAllResponseHeaders()) : null 
                      , n = f.responseType && "text" !== f.responseType ? l.response : l.responseText
                      , o = {
                        data: s(n, r, f.transformResponse),
                        status: 1223 === l.status ? 204 : l.status,
                        statusText: 1223 === l.status ? "No Content" : l.statusText,
                        headers: r,
                        config: f,
                        request: l
                    };
                    c(e, t, o),
                    l = null 
                }
            }
            ,
            l.onerror = function() {
                t(new Error("Network Error")),
                l = null 
            }
            ,
            l.ontimeout = function() {
                var e = new Error("timeout of " + f.timeout + "ms exceeded");
                e.timeout = f.timeout,
                e.code = "ECONNABORTED",
                t(e),
                l = null 
            }
            ,
            n.isStandardBrowserEnv()) {
                var g = r(13)
                  , v = f.withCredentials || u(f.url) ? g.read(f.xsrfCookieName) : void 0;
                v && (d[f.xsrfHeaderName] = v)
            }
            if ("setRequestHeader" in l && n.forEach(d, function(e, t) {
                "undefined" == typeof p && "content-type" === t.toLowerCase() ? delete d[t] : l.setRequestHeader(t, e)
            }),
            f.withCredentials && (l.withCredentials = !0),
            f.responseType)
                try {
                    l.responseType = f.responseType
                } catch (x) {
                    if ("json" !== l.responseType)
                        throw x
                }
            f.progress && ("post" === f.method || "put" === f.method ? l.upload.addEventListener("progress", f.progress) : "get" === f.method && l.addEventListener("progress", f.progress)),
            void 0 === p && (p = null ),
            l.send(p)
        }
    }
    , function(e, t, r) {
        "use strict";
        function n(e) {
            return encodeURIComponent(e).replace(/%40/gi, "@").replace(/%3A/gi, ":").replace(/%24/g, "$").replace(/%2C/gi, ",").replace(/%20/g, "+").replace(/%5B/gi, "[").replace(/%5D/gi, "]")
        }
        var o = r(3);
        e.exports = function(e, t, r) {
            if (!t)
                return e;
            var i;
            if (r)
                i = r(t);
            else if (o.isURLSearchParams(t))
                i = t.toString();
            else {
                var s = [];
                o.forEach(t, function(e, t) {
                    null  !== e && "undefined" != typeof e && (o.isArray(e) && (t += "[]"),
                    o.isArray(e) || (e = [e]),
                    o.forEach(e, function(e) {
                        o.isDate(e) ? e = e.toISOString() : o.isObject(e) && (e = JSON.stringify(e)),
                        s.push(n(t) + "=" + n(e))
                    }))
                }),
                i = s.join("&")
            }
            return i && (e += (-1 === e.indexOf("?") ? "?" : "&") + i),
            e
        }
    }
    , function(e, t, r) {
        "use strict";
        var n = r(3);
        e.exports = function(e) {
            var t, r, o, i = {};
            return e ? (n.forEach(e.split("\n"), function(e) {
                o = e.indexOf(":"),
                t = n.trim(e.substr(0, o)).toLowerCase(),
                r = n.trim(e.substr(o + 1)),
                t && (i[t] = i[t] ? i[t] + ", " + r : r)
            }),
            i) : i
        }
    }
    , function(e, t, r) {
        "use strict";
        var n = r(3);
        e.exports = function(e, t, r) {
            return n.forEach(r, function(r) {
                e = r(e, t)
            }),
            e
        }
    }
    , function(e, t, r) {
        "use strict";
        var n = r(3);
        e.exports = n.isStandardBrowserEnv() ? function() {
            function e(e) {
                var t = e;
                return r && (o.setAttribute("href", t),
                t = o.href),
                o.setAttribute("href", t),
                {
                    href: o.href,
                    protocol: o.protocol ? o.protocol.replace(/:$/, "") : "",
                    host: o.host,
                    search: o.search ? o.search.replace(/^\?/, "") : "",
                    hash: o.hash ? o.hash.replace(/^#/, "") : "",
                    hostname: o.hostname,
                    port: o.port,
                    pathname: "/" === o.pathname.charAt(0) ? o.pathname : "/" + o.pathname
                }
            }
            var t, r = /(msie|trident)/i.test(navigator.userAgent), o = document.createElement("a");
            return t = e(window.location.href),
            function(r) {
                var o = n.isString(r) ? e(r) : r;
                return o.protocol === t.protocol && o.host === t.host
            }
        }() : function() {
            return function() {
                return !0
            }
        }()
    }
    , function(e, t) {
        "use strict";
        function r() {
            this.message = "String contains an invalid character"
        }
        function n(e) {
            for (var t, n, i = String(e), s = "", u = 0, a = o; i.charAt(0 | u) || (a = "=",
            u % 1); s += a.charAt(63 & t >> 8 - u % 1 * 8)) {
                if (n = i.charCodeAt(u += .75),
                n > 255)
                    throw new r;
                t = t << 8 | n
            }
            return s
        }
        var o = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        r.prototype = new Error,
        r.prototype.code = 5,
        r.prototype.name = "InvalidCharacterError",
        e.exports = n
    }
    , function(e, t) {
        "use strict";
        e.exports = function(e, t, r) {
            var n = r.config.validateStatus;
            r.status && n && !n(r.status) ? t(r) : e(r)
        }
    }
    , function(e, t, r) {
        "use strict";
        var n = r(3);
        e.exports = n.isStandardBrowserEnv() ? function() {
            return {
                write: function(e, t, r, o, i, s) {
                    var u = [];
                    u.push(e + "=" + encodeURIComponent(t)),
                    n.isNumber(r) && u.push("expires=" + new Date(r).toGMTString()),
                    n.isString(o) && u.push("path=" + o),
                    n.isString(i) && u.push("domain=" + i),
                    s === !0 && u.push("secure"),
                    document.cookie = u.join("; ")
                },
                read: function(e) {
                    var t = document.cookie.match(new RegExp("(^|;\\s*)(" + e + ")=([^;]*)"));
                    return t ? decodeURIComponent(t[3]) : null 
                },
                remove: function(e) {
                    this.write(e, "", Date.now() - 864e5)
                }
            }
        }() : function() {
            return {
                write: function() {},
                read: function() {
                    return null 
                },
                remove: function() {}
            }
        }()
    }
    , function(e, t, r) {
        "use strict";
        function n() {
            this.handlers = []
        }
        var o = r(3);
        n.prototype.use = function(e, t) {
            return this.handlers.push({
                fulfilled: e,
                rejected: t
            }),
            this.handlers.length - 1
        }
        ,
        n.prototype.eject = function(e) {
            this.handlers[e] && (this.handlers[e] = null )
        }
        ,
        n.prototype.forEach = function(e) {
            o.forEach(this.handlers, function(t) {
                null  !== t && e(t)
            })
        }
        ,
        e.exports = n
    }
    , function(e, t) {
        "use strict";
        e.exports = function(e) {
            return /^([a-z][a-z\d\+\-\.]*:)?\/\//i.test(e)
        }
    }
    , function(e, t) {
        "use strict";
        e.exports = function(e, t) {
            return e.replace(/\/+$/, "") + "/" + t.replace(/^\/+/, "")
        }
    }
    , function(e, t) {
        "use strict";
        e.exports = function(e, t) {
            return function() {
                for (var r = new Array(arguments.length), n = 0; n < r.length; n++)
                    r[n] = arguments[n];
                return e.apply(t, r)
            }
        }
    }
    , function(e, t) {
        "use strict";
        e.exports = function(e) {
            return function(t) {
                return e.apply(null , t)
            }
        }
    }
    ])
});
//# sourceMappingURL=axios.min.map
