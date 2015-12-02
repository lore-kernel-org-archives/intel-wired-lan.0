From: Joe Perches <joe@perches.com>
Date: Wed, 02 Dec 2015 13:09:16 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix i40e_print_features() VEB
	mode output
In-Reply-To: <20151202.154800.1567031979226825020.davem@davemloft.net>
References: <1449045535.3716.10.camel@perches.com>
 <1449050215.3224.29.camel@intel.com> <1449051149.3716.20.camel@perches.com>
 <20151202.154800.1567031979226825020.davem@davemloft.net>
Message-ID: <1449090556.3716.61.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-12-02 at 15:48 -0500, David Miller wrote:
> From: Joe Perches <joe@perches.com> 02 Dec 2015 02:12:29 -0800
> > On Wed, 2015-12-02 at 01:56 -0800, Jeff Kirsher wrote:
> >> On Wed, 2015-12-02 at 00:38 -0800, Joe Perches wrote:
> >> > Noticed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>?
> >> Don't you mean Reported-by? ?I am not aware of Noticed-by as being a
> >> recognized signature.?
> > At least for the get_maintainer script, "-by:" is a signature
> Is patchwork using the same regexp?? If not, for the time being don't
> user non-standard tags, and furthermore please ask the patchwork folks
> to use something similar to getmaintainer.pl

It doesn't seem so.

????response_re = re.compile(
????????r'^(Tested|Reviewed|Acked|Signed-off|Nacked|Reported)-by: .*$',
????????re.M | re.I)

patchwork also doesn't seem very forgiving of misformatted signatures.
(btw: Junio Hamano seems to prefer calling them trailers)

And patchwork doesn't seem to handle "cc: " markers either.
