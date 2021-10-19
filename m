From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 19 Oct 2021 17:53:15 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Add missing device ids
In-Reply-To: <c2e59ebe-4a7b-b2d7-f15d-759ad26c006b@molgen.mpg.de>
References: <20211019152758.58277-1-anthony.l.nguyen@intel.com>
 <c2e59ebe-4a7b-b2d7-f15d-759ad26c006b@molgen.mpg.de>
Message-ID: <1494d7bcbed00caff6f6391512dd8db5256d3770.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-10-19 at 18:24 +0200, Paul Menzel wrote:

Hi Paul,

> Dear Tony,
> 
> 
> Am 19.10.21 um 17:27 schrieb Tony Nguyen:
> 
> Please mention E810 in the git commit message summary:
> 
> > ice: Add missing E810 device ids

I will fix that, thanks for the suggestion.

> > As part of support for E810 XXV devices, some device ids were >
> > inadvertently left out. Add those missing ids.
> Please mention the source of these IDs.

I'm not sure I get this comment. These are the IDs for the NIC itself.

Thanks,
Tony

> Kind regards,
> 
> Paul
> 
> 
> > Fixes: 195fb97766da ("ice: add additional E810 device id")
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> > ? drivers/net/ethernet/intel/ice/ice_common.c | 2 ++
> > ? drivers/net/ethernet/intel/ice/ice_devids.h | 4 ++++
> > ? drivers/net/ethernet/intel/ice/ice_main.c?? | 2 ++
> > ? 3 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> > b/drivers/net/ethernet/intel/ice/ice_common.c
> > index 2fb81e359cdf..df5ad4de1f00 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_common.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> > @@ -25,6 +25,8 @@ static enum ice_status ice_set_mac_type(struct
> > ice_hw *hw)
> > ????????case ICE_DEV_ID_E810C_BACKPLANE:
> > ????????case ICE_DEV_ID_E810C_QSFP:
> > ????????case ICE_DEV_ID_E810C_SFP:
> > +???????case ICE_DEV_ID_E810_XXV_BACKPLANE:
> > +???????case ICE_DEV_ID_E810_XXV_QSFP:
> > ????????case ICE_DEV_ID_E810_XXV_SFP:
> > ????????????????hw->mac_type = ICE_MAC_E810;
> > ????????????????break;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h
> > b/drivers/net/ethernet/intel/ice/ice_devids.h
> > index 9d8194671f6a..ef4392e6e244 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_devids.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_devids.h
> > @@ -21,6 +21,10 @@
> > ? #define ICE_DEV_ID_E810C_QSFP?????????0x1592
> > ? /* Intel(R) Ethernet Controller E810-C for SFP */
> > ? #define ICE_DEV_ID_E810C_SFP??????????0x1593
> > +/* Intel(R) Ethernet Controller E810-XXV for backplane */
> > +#define ICE_DEV_ID_E810_XXV_BACKPLANE??0x1599
> > +/* Intel(R) Ethernet Controller E810-XXV for QSFP */
> > +#define ICE_DEV_ID_E810_XXV_QSFP???????0x159A
> > ? /* Intel(R) Ethernet Controller E810-XXV for SFP */
> > ? #define ICE_DEV_ID_E810_XXV_SFP???????????????0x159B
> > ? /* Intel(R) Ethernet Connection E823-C for backplane */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> > b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 94037881bfd8..06fa93e597fb 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5020,6 +5020,8 @@ static const struct pci_device_id
> > ice_pci_tbl[] = {
> > ????????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_BACKPLANE), 0 },
> > ????????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_QSFP), 0 },
> > ????????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_SFP), 0 },
> > +???????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_BACKPLANE), 0 },
> > +???????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_QSFP), 0 },
> > ????????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_SFP), 0 },
> > ????????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_BACKPLANE), 0 },
> > ????????{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_QSFP), 0 },
> > 

