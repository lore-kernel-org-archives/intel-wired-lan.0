From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 08 Jan 2016 03:39:00 -0800
Subject: [Intel-wired-lan] igb: enable WoL for OEM devices regardless of
	EEPROM setting
In-Reply-To: <20160105180828.14555.93037.stgit@htfujina-fc.jf.intel.com>
References: <20160105180828.14555.93037.stgit@htfujina-fc.jf.intel.com>
Message-ID: <1452253140.19358.41.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-01-05 at 10:08 -0800, Fujinaka, Todd wrote:
> Override EEPROM settings for specific OEM devices.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
> ?drivers/net/ethernet/intel/igb/igb_main.c |???20
> ++++++++++++++++++++
> ?1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 637135e..f413ce1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2590,6 +2590,26 @@ static int igb_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
> ?		adapter->wol = 0;
> ?	}
> ?
> +	/* Some vendors want the ability to Use the EEPROM setting
> as
> +	?* enable/disable only, and not for capability
> +	?*/
> +	if ((((hw->mac.type == e1000_i350) ||
> +	??????(hw->mac.type == e1000_i354))) &&
> +			((pdev->subsystem_vendor ==
> PCI_VENDOR_ID_DELL))) {

Looks like someone got a little overzealous with parenthesis's and the
line is not indented correctly (specifically the third line is indented
too much)

> +		adapter->flags |= IGB_FLAG_WOL_SUPPORTED;
> +		adapter->wol = 0;
> +	}
> +	if (hw->mac.type == e1000_i350) {
> +		if (((pdev->subsystem_device == 0x5001) ||
> +		?????(pdev->subsystem_device == 0x5002)) &&
> +				(hw->bus.func == 0)) {

Indentation is incorrect for the third wrapped line above, too many
tabs. ?It should have 2 tabs and 4 spaces.

> +			adapter->flags |= IGB_FLAG_WOL_SUPPORTED;
> +			adapter->wol = 0;
> +		}
> +		if (pdev->subsystem_device == 0x1F52)
> +			adapter->flags |= IGB_FLAG_WOL_SUPPORTED;
> +	}
> +
> ?	device_set_wakeup_enable(&adapter->pdev->dev,
> ?				?adapter->flags &
> IGB_FLAG_WOL_SUPPORTED);
> ?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160108/b96d3a6c/attachment-0001.asc>
