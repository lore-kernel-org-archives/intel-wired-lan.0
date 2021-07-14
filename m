From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 14 Jul 2021 11:43:13 +0300
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: Separate TGP from SPT
In-Reply-To: <CAAd53p5rKLNv9w4Z8YBSW=ztLAV68mc+BxUSyfOi11TLSuh6bg@mail.gmail.com>
References: <20210712133500.1126371-1-kai.heng.feng@canonical.com>
 <d0bc9dbd-9b7a-5807-2ade-e710964a05a1@intel.com>
 <CAAd53p5rKLNv9w4Z8YBSW=ztLAV68mc+BxUSyfOi11TLSuh6bg@mail.gmail.com>
Message-ID: <f7c867e5-ee94-cd40-fe88-f8b5b383f8f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/14/2021 07:19, Kai-Heng Feng wrote:
> Hi Sasha,
> 
> On Wed, Jul 14, 2021 at 1:58 AM Sasha Neftin <sasha.neftin@intel.com> wrote:
>>
>> On 7/12/2021 16:34, Kai-Heng Feng wrote:
>>> Separate TGP from SPT so we can apply specific quirks to TGP.
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>    drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
>>>    drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 ++++++++++++++++++++
>>>    drivers/net/ethernet/intel/e1000e/netdev.c  | 13 +++++++------
>>>    3 files changed, 30 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
>>> index 5b2143f4b1f8..3178efd98006 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
>>> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
>>> @@ -113,7 +113,8 @@ enum e1000_boards {
>>>        board_pch2lan,
>>>        board_pch_lpt,
>>>        board_pch_spt,
>>> -     board_pch_cnp
>>> +     board_pch_cnp,
>> Hello Kai-Heng,
>> I would agree with you here. I would suggest extending it also for other
>> PCH (at least ADP and MTP).  The same controller on a different PCH.
>> We will be able to differentiate between boards via MAC type and submit
>> quirks if need.
> 
> Sure, will do in v2.
> 
> The issue patch [3/3] addresses may be fixed by [1], but I'll need to
> dig the affected system out and do some testing.
> Meanwhile, many users are affected by the RX issue patch [2/3]
> addresses, so it'll be great if someone can review it.
> 
> [1] https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=250480
regards patches 2/3 and 3/3: looks it is not right place for temporary 
w.a. Let's work with alexander.usyskin at intel.com to understand to root 
cause and right place.
> 
> Kai-Heng
> 
>>> +     board_pch_tgp
>>>    };
>>>
>>>    struct e1000_ps_page {
>>> @@ -499,6 +500,7 @@ extern const struct e1000_info e1000_pch2_info;
>>>    extern const struct e1000_info e1000_pch_lpt_info;
>>>    extern const struct e1000_info e1000_pch_spt_info;
>>>    extern const struct e1000_info e1000_pch_cnp_info;
>>> +extern const struct e1000_info e1000_pch_tgp_info;
>>>    extern const struct e1000_info e1000_es2_info;
>>>
>>>    void e1000e_ptp_init(struct e1000_adapter *adapter);
>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> index cf7b3887da1d..654dbe798e55 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> @@ -5967,3 +5967,23 @@ const struct e1000_info e1000_pch_cnp_info = {
>>>        .phy_ops                = &ich8_phy_ops,
>>>        .nvm_ops                = &spt_nvm_ops,
>>>    };
>>> +
>>> +const struct e1000_info e1000_pch_tgp_info = {
>>> +     .mac                    = e1000_pch_tgp,
>>> +     .flags                  = FLAG_IS_ICH
>>> +                               | FLAG_HAS_WOL
>>> +                               | FLAG_HAS_HW_TIMESTAMP
>>> +                               | FLAG_HAS_CTRLEXT_ON_LOAD
>>> +                               | FLAG_HAS_AMT
>>> +                               | FLAG_HAS_FLASH
>>> +                               | FLAG_HAS_JUMBO_FRAMES
>>> +                               | FLAG_APME_IN_WUC,
>>> +     .flags2                 = FLAG2_HAS_PHY_STATS
>>> +                               | FLAG2_HAS_EEE,
>>> +     .pba                    = 26,
>>> +     .max_hw_frame_size      = 9022,
>>> +     .get_variants           = e1000_get_variants_ich8lan,
>>> +     .mac_ops                = &ich8_mac_ops,
>>> +     .phy_ops                = &ich8_phy_ops,
>>> +     .nvm_ops                = &spt_nvm_ops,
>>> +};
>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> index d150dade06cf..5835d6cf2f51 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> @@ -51,6 +51,7 @@ static const struct e1000_info *e1000_info_tbl[] = {
>>>        [board_pch_lpt]         = &e1000_pch_lpt_info,
>>>        [board_pch_spt]         = &e1000_pch_spt_info,
>>>        [board_pch_cnp]         = &e1000_pch_cnp_info,
>>> +     [board_pch_tgp]         = &e1000_pch_tgp_info,
>>>    };
>>>
>>>    struct e1000_reg_info {
>>> @@ -7843,12 +7844,12 @@ static const struct pci_device_id e1000_pci_tbl[] = {
>>>        { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V11), board_pch_cnp },
>>>        { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_LM12), board_pch_spt },
>>>        { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_CMP_I219_V12), board_pch_spt },
>>> -     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM13), board_pch_cnp },
>>> -     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V13), board_pch_cnp },
>>> -     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM14), board_pch_cnp },
>>> -     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_cnp },
>>> -     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_cnp },
>>> -     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_cnp },
>>> +     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM13), board_pch_tgp },
>>> +     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V13), board_pch_tgp },
>>> +     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM14), board_pch_tgp },
>>> +     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V14), board_pch_tgp },
>>> +     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_LM15), board_pch_tgp },
>>> +     { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_TGP_I219_V15), board_pch_tgp },
>>>        { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM16), board_pch_cnp },
>>>        { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V16), board_pch_cnp },
>>>        { PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM17), board_pch_cnp },
>>>
>> Thanks,
>> Sasha

