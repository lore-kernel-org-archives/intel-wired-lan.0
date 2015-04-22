From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 22 Apr 2015 01:13:13 -0700
Subject: [Intel-wired-lan] [PATCH v2] igb: disable IPv6 extension header
 processing
In-Reply-To: <20150417182418.13628.80701.stgit@htfujina-fc.jf.intel.com>
References: <20150417182418.13628.80701.stgit@htfujina-fc.jf.intel.com>
Message-ID: <1429690393.2638.218.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-17 at 11:24 -0700, Todd Fujinaka wrote:
> Disable IPv6 extension header processing as per hardware errata.
> 
> Also fix copyright date.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c   |   12 ++++++++----
>  drivers/net/ethernet/intel/igb/e1000_defines.h |    3 ++-
>  2 files changed, 10 insertions(+), 5 deletions(-)

Thanks Todd, applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150422/f801c728/attachment.asc>
