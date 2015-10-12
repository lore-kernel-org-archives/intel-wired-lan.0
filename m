From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Mon, 12 Oct 2015 12:58:09 +0200
Subject: [Intel-wired-lan] e1000e: hard system lockup on Linux 4.2
In-Reply-To: <8F4C390AFA9F4444A4AA77F4A3BEC78A059D9C26@HASMSX110.ger.corp.intel.com>
References: <CAHmME9r9PbyqpRd6shT8Ep5WmLbUBv9dOdXRAzhGykgT0AM+sA@mail.gmail.com>
 <8F4C390AFA9F4444A4AA77F4A3BEC78A059D9C26@HASMSX110.ger.corp.intel.com>
Message-ID: <CAHmME9rvnmdn-1Yy6jJYsY-4Ocb5bjimftRpMhxrmTYhOn07DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Oct 12, 2015 8:59 AM, "Avargil, Raanan" <raanan.avargil@intel.com> wrote:
>
> Your analysis is correct.
> Commit 37b12910dd11d9ab969f2c310dc9160b7f3e3405 fixes the lockup issue,
and according to my last check it is in 4.3-rc5.

Cool okay.
But can we please get this patched marked for stable? It should be
backported to the upcoming 4.2.4.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151012/0a335caa/attachment.html>
