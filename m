From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 12 Nov 2018 09:13:56 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] igc: Remove obsolete IGC_ERR
 define
In-Reply-To: <20181112090520.31496-1-sasha.neftin@intel.com>
References: <20181112090520.31496-1-sasha.neftin@intel.com>
Message-ID: <f9ff877c5908a58ad7f63ebc8ebb32e0157d9073.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-11-12 at 11:05 +0200, Sasha Neftin wrote:
> Address community comment.
> Remove obsolete IGC_ERR define and use dev_err method.
> Suggested by Joe Perches.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 2 --
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)

Was there supposed to be a patch 1/2?  The title of this patch would
lead me to believe that there was another patch in this series that I
am missing.  Is the patch title a typo?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181112/66962bee/attachment.asc>
