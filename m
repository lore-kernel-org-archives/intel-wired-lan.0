From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 25 Jul 2018 14:52:42 -0700
Subject: [Intel-wired-lan] [PATCH v1 1/4] igb: Remove unnecessary
 include of <linux/pci-aspm.h>
In-Reply-To: <153254834342.92573.16877025672192312745.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153254834342.92573.16877025672192312745.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <c3c236249fc8fc270e7100ed30c15a4269ab3eae.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-07-25 at 14:52 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The igb driver doesn't need anything provided by pci-aspm.h, so
> remove
> the unnecessary include of it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

I am fine with you picking up this change.

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    1 -
>  1 file changed, 1 deletion(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180725/7cc6d884/attachment.asc>
