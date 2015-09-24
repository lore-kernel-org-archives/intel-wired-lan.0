From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 23 Sep 2015 21:54:53 -0700
Subject: [Intel-wired-lan] [net PATCH 1/3] i40e: Fix handling of napi
	budget
In-Reply-To: <20150922213529.2774.42390.stgit@ahduyck-vm-fedora22>
References: <20150922213002.2774.37924.stgit@ahduyck-vm-fedora22>
 <20150922213529.2774.42390.stgit@ahduyck-vm-fedora22>
Message-ID: <1443070493.2987.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-09-22 at 14:35 -0700, Alexander Duyck wrote:
> The polling routine for i40e was rounding up the budget for Rx
> cleanup to
> 1.  This is incorrect as netpoll will call is expecting no Rx to be
> processed as the budget passed was 0.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |    5 +++++
>  1 file changed, 5 insertions(+)

This does not apply cleanly to my next-queue tree, dev-queue branch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150923/8313e6e7/attachment.asc>
