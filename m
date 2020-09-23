From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 23 Sep 2020 22:44:10 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Power cycle phy on PM resume
In-Reply-To: <20200923121748.GE3770354@lunn.ch>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <20200923121748.GE3770354@lunn.ch>
Message-ID: <F6075687-7BC4-4348-86A8-29D83B7E5AAC@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Andrew,

> On Sep 23, 2020, at 20:17, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> On Wed, Sep 23, 2020 at 03:47:51PM +0800, Kai-Heng Feng wrote:
>> We are seeing the following error after S3 resume:
>> [  704.746874] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
>> [  704.844232] e1000e 0000:00:1f.6 eno1: MDI Write did not complete
>> [  704.902817] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
>> [  704.903075] e1000e 0000:00:1f.6 eno1: reading PHY page 769 (or 0x6020 shifted) reg 0x17
>> [  704.903281] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
>> [  704.903486] e1000e 0000:00:1f.6 eno1: writing PHY page 769 (or 0x6020 shifted) reg 0x17
>> [  704.943155] e1000e 0000:00:1f.6 eno1: MDI Error
>> ...
>> [  705.108161] e1000e 0000:00:1f.6 eno1: Hardware Error
>> 
>> Since we don't know what platform firmware may do to the phy, so let's
>> power cycle the phy upon system resume to resolve the issue.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 664e8ccc88d2..c2a87a408102 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -6968,6 +6968,8 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>> 	    !e1000e_check_me(hw->adapter->pdev->device))
>> 		e1000e_s0ix_exit_flow(adapter);
>> 
>> +	e1000_power_down_phy(adapter);
>> +
> 
> static void e1000_power_down_phy(struct e1000_adapter *adapter)
> {
> 	struct e1000_hw *hw = &adapter->hw;
> 
> 	/* Power down the PHY so no link is implied when interface is down *
> 	 * The PHY cannot be powered down if any of the following is true *
> 	 * (a) WoL is enabled
> 	 * (b) AMT is active
> 	 * (c) SoL/IDER session is active
> 	 */
> 	if (!adapter->wol && hw->mac_type >= e1000_82540 &&
> 	   hw->media_type == e1000_media_type_copper) {

Looks like the the function comes from e1000, drivers/net/ethernet/intel/e1000/e1000_main.c.
However, this patch is for e1000e, so the function with same name is different.

> 
> Could it be coming out of S3 because it just received a WoL?

No, the issue can be reproduced by pressing keyboard or rtcwake.

> 
> It seems unlikely that it is the MII_CR_POWER_DOWN which is helping,
> since that is an MDIO write itself. Do you actually know how this call
> to e1000_power_down_phy() fixes the issues?

I don't know from hardware's perspective, but I think the comment on e1000_power_down_phy_copper() can give us some insight:

/**
 * e1000_power_down_phy_copper - Restore copper link in case of PHY power down
 * @hw: pointer to the HW structure
 *
 * In the case of a PHY power down to save power, or to turn off link during a
 * driver unload, or wake on lan is not enabled, restore the link to previous
 * settings.                       
 **/
void e1000_power_down_phy_copper(struct e1000_hw *hw)
{
        u16 mii_reg = 0;

        /* The PHY will retain its settings across a power down/up cycle */
        e1e_rphy(hw, MII_BMCR, &mii_reg);
        mii_reg |= BMCR_PDOWN;
        e1e_wphy(hw, MII_BMCR, mii_reg);
        usleep_range(1000, 2000);
}

Kai-Heng

> 
>   Andrew

