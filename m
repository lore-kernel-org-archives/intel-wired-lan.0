From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 9 Jul 2018 09:13:05 -0700
Subject: [Intel-wired-lan] [PATCH v3 10/11] igc: Add setup link
 functionality
In-Reply-To: <0aa506cb-f7e3-0b44-1f77-c56b41cbe961@intel.com>
References: <20180624084525.10374-1-sasha.neftin@intel.com>
 <5cbe68b0-9409-adca-c040-cfc5953c884c@oracle.com>
 <0aa506cb-f7e3-0b44-1f77-c56b41cbe961@intel.com>
Message-ID: <8747a5ef-22fb-5bde-d788-756fac6a93ef@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/4/2018 8:19 AM, Neftin, Sasha wrote:
> On 6/29/2018 18:03, Shannon Nelson wrote:
>> On 6/24/2018 1:45 AM, Sasha Neftin wrote:

[...]

>>> +/**
>>> + *? igc_wait_autoneg - Wait for auto-neg completion
>>> + *? @hw: pointer to the HW structure
>>> + *
>>> + *? Waits for auto-negotiation to complete or for the 
>>> auto-negotiation time
>>> + *? limit to expire, which ever happens first.
>>> + **/
>>> +static s32 igc_wait_autoneg(struct e1000_hw *hw)
>>> +{
>>> +??? s32 ret_val = 0;
>>> +??? u16 i, phy_status;
>>> +
>>> +??? /* Break after autoneg completes or PHY_AUTO_NEG_LIMIT expires. */
>>> +??? for (i = PHY_AUTO_NEG_LIMIT; i > 0; i--) {
>>> +??????? ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
>>> +??????? if (ret_val)
>>> +??????????? break;
>>> +??????? ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
>>> +??????? if (ret_val)
>>> +??????????? break;
>>> +??????? if (phy_status & MII_SR_AUTONEG_COMPLETE)
>>> +??????????? break;
>>> +??????? msleep(100);
>>> +??? }
>>> +
>>> +??? /* PHY_AUTO_NEG_TIME expiration doesn't guarantee auto-negotiation
>>> +???? * has completed.
>>> +???? */
>>
>> Should you return an error value if the wait time expired?
>>
> ret_val is returned. do you mean something else?

Should some non-zero value be returned if the for-loop ran out and 
MII_SR_AUTONEG_COMPLETE was never set?

sln

