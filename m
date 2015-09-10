From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Thu, 10 Sep 2015 17:55:54 +0000
Subject: [Intel-wired-lan] [PATCH] igb: don't unmap hw_addr if its NULL
In-Reply-To: <1441858049-44827-1-git-send-email-jarod@redhat.com>
References: <1441858049-44827-1-git-send-email-jarod@redhat.com>
Message-ID: <9AC147AD-6D52-4A7D-BE5B-3A40F8D22B1A@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Sep 9, 2015, at 9:07 PM, Jarod Wilson <jarod@redhat.com> wrote:
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index e174fbb..a5e0022 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2823,7 +2823,8 @@ static void igb_remove(struct pci_dev *pdev)
> 
> 	igb_clear_interrupt_scheme(adapter);
> 
> -	pci_iounmap(pdev, hw->hw_addr);
> +	if (hw->hw_addr)
> +		pci_iounmap(pdev, hw->hw_addr);
> 	if (hw->flash_address)
> 		iounmap(hw->flash_address);
> 	pci_release_selected_regions(pdev,

I don't think that this is entirely the right solution. In ixgbe we have a separate pointer, io_addr, used to manage the resource, so that the space can be freed even after hw_addr is cleared. With the approach above, the pci_iounmap will not ever be called on the space. You can see how ixgbe is doing it.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150910/f8443674/attachment.asc>
