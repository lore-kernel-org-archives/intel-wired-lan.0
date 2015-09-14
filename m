From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Mon, 14 Sep 2015 16:48:48 +0000
Subject: [Intel-wired-lan] [next-queue 1/8] e1000: clean up the
	useless	'continue' statement
In-Reply-To: <1442212070-24937-2-git-send-email-sakiwit@gmail.com>
References: <1442212070-24937-1-git-send-email-sakiwit@gmail.com>
 <1442212070-24937-2-git-send-email-sakiwit@gmail.com>
Message-ID: <32D3D43C-B677-4C70-8915-3B07B1175C66@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Sep 13, 2015, at 11:27 PM, J?an Sacren <sakiwit@gmail.com> wrote:
> 
> We can delete the 'continue' statement as it is in the end of the block
> and doesn't do any good. To make it distinctive, put an empty line above
> the checking block.
> 
> Additionally add a pair of braces in the 'else' branch.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> drivers/net/ethernet/intel/e1000/e1000_main.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 74dc15055971..47397d7b97df 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1199,12 +1199,13 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 		for (i = 0; i < 32; i++) {
> 			hw->phy_addr = i;
> 			e1000_read_phy_reg(hw, PHY_ID2, &tmp);
> +
> 			if (tmp == 0 || tmp == 0xFF) {
> 				if (i == 31)
> 					goto err_eeprom;
> -				continue;
> -			} else
> +			} else {
> 				break;
> +			}
> 		}
> 	}

I think I would prefer leaving the continue, deleting the else and undenting the break one level. Since the first portion of the original if statement will never "fall through", the else is really the redundant part.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150914/c27940eb/attachment.asc>
