From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 18 May 2015 15:45:59 -0700
Subject: [Intel-wired-lan] [net-next PATCH 1/8] flow: create nl
 interface to wrap low level flow msg details
In-Reply-To: <20150518220327.14831.64876.stgit@azvasil-mobl1.amr.corp.intel.com>
References: <20150518220327.14831.64876.stgit@azvasil-mobl1.amr.corp.intel.com>
Message-ID: <1431989159.2558.14.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-05-18 at 15:03 -0700, John Fastabend wrote:
> From: John Fastabend <john.r.fastabend@intel.com>
> 
> Some low-level functions that can be used to interface with
> API from other programs without having to invoke NETLINK
> primitives.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  include/flowlib_nl.h |   75 ++++++
>  lib/Makefile.am      |    2 
>  lib/flowlib_nl.c     |  657
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/flow.c           |  266 +++-----------------
>  4 files changed, 773 insertions(+), 227 deletions(-)
>  create mode 100644 include/flowlib_nl.h
>  create mode 100644 lib/flowlib_nl.c

Will the other 7 patches be posted as well? :-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150518/6e3b451d/attachment.asc>
