From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 18 Jun 2015 19:22:33 -0700
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: update fm10k_slot_warn to
 use pcie_get_minimum link
In-Reply-To: <1434405656-10465-5-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
 <1434405656-10465-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <55837CE9.1080706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/15/2015 03:00 PM, Jacob Keller wrote:
> This is useful in cases where we connect to a slot at Gen3, but the slot
> is behind a bus which only connected at Gen2. This generally only
> happens when a PCIe switch is in the sequence of devices, and can be
> very confusing when you see slow performance with no obvious cause.
>
> I am aware this patch has a few lines that break 80 characters, but
> there does not seem to be a readable way to format them to less than 80
> characters. Suggestions welcome.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 105 +++++++++++++++++++--------
>   1 file changed, 76 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index 37cd78f3ce24..d8ab6cdca456 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -1703,22 +1703,86 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
>   
>   static void fm10k_slot_warn(struct fm10k_intfc *interface)
>   {
> -	struct device *dev = &interface->pdev->dev;
> +	enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;
> +	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
>   	struct fm10k_hw *hw = &interface->hw;
> +	int max_gts = 0, expected_gts = 0;
>   
> -	if (hw->mac.ops.is_slot_appropriate(hw))

If I am not mistaken I believe this is the only spot that uses the 
is_slot_appropriate function in the upstream driver.  You could just 
drop it from the code if that is the case.  I'll try to get to it in a 
couple of weeks when I get back from vacation otherwise.

- Alex
