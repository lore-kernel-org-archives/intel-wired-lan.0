From: Cyril Novikov <cnovikov@lynx.com>
Date: Fri, 29 Oct 2021 16:06:26 -0700
Subject: [Intel-wired-lan] [PATCH net] ixgbe: set X550 MDIO speed before
 talking to PHY
In-Reply-To: <89af2e39-fe5c-c285-7805-8c7a6a5a2e51@molgen.mpg.de>
References: <81be24c4-a7e4-0761-abf4-204f4849b6eb@lynx.com>
 <89af2e39-fe5c-c285-7805-8c7a6a5a2e51@molgen.mpg.de>
Message-ID: <df9504c8-bdfd-9cc0-d002-f1e59f57a79b@lynx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/28/2021 11:47 PM, Paul Menzel wrote:
> Dear Cyril,
> 
> 
> On 29.10.21 03:03, Cyril Novikov wrote:
>> The MDIO bus speed must be initialized before talking to the PHY the 
>> first
>> time in order to avoid talking to it using a speed that the PHY doesn't
>> support.
>>
>> This fixes HW initialization error -17 (IXGBE_ERR_PHY_ADDR_INVALID) on
>> Denverton CPUs (a.k.a. the Atom C3000 family) on ports with a 10Gb 
>> network
>> plugged in. On those devices, HLREG0[MDCSPD] resets to 1, which combined
>> with the 10Gb network results in a 24MHz MDIO speed, which is apparently
>> too fast for the connected PHY. PHY register reads over MDIO bus return
>> garbage, leading to initialization failure.
> 
> Maybe add a Fixes tag?

This is my first patch submission for Linux kernel. What I read about 
the Fixes tag says it identifies a previous commit that had introduced 
the bug. I have no idea which commit introduced this bug. We saw it in 
4.19 which probably means the bug was always there and is not a 
regression. It's also quite possible the original commit was correct for 
the hardware existing at that time and it only started behaving 
incorrectly with new hardware, so it wasn't actually a bug at the time 
it was submitted. I also don't have the capability or time to bisect 
this problem.

>> Signed-off-by: Cyril Novikov <cnovikov@lynx.com>
>> ---
>> ? drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 3 +++
>> ? 1 file changed, 3 insertions(+)
>>
>> Reproduced with Linux kernel 4.19 and 5.15-rc7. Can be reproduced using
>> the following setup:
>>
>> * Use an Atom C3000 family system with at least one X550 LAN on the SoC
>> * Disable PXE or other BIOS network initialization if possible
>> ?? (the interface must not be initialized before Linux boots)
>> * Connect a live 10Gb Ethernet cable to an X550 port
>> * Power cycle (not reset, doesn't always work) the system and boot Linux
>> * Observe: ixgbe interfaces w/ 10GbE cables plugged in fail with error 
>> -17
> 
> Why not add that to the commit message?

I wasn't sure if the reproduction scenario belonged to the commit 
message, and have no problem adding it if you believe it does.

>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c 
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
>> index 9724ffb16518..e4b50c7781ff 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
>> @@ -3405,6 +3405,9 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw 
>> *hw)
>> ????? /* flush pending Tx transactions */
>> ????? ixgbe_clear_tx_pending(hw);
>> +??? /* set MDIO speed before talking to the PHY in case it's the 1st 
>> time */
>> +??? ixgbe_set_mdio_speed(hw);
>> +
>> ????? /* PHY ops must be identified and initialized prior to reset */
>> ????? status = hw->phy.ops.init(hw);
>> ????? if (status == IXGBE_ERR_SFP_NOT_SUPPORTED ||
>>
> 
> Is `ixgbe_set_mdio_speed(hw)` at the end of the function then still needed?

The code between the two calls issues a global reset to the MAC and 
optionally the link, depending on some flags. That may reset the MDIO 
speed back to the wrong value or, according to the comments in the code, 
may reset the PHY and result in renegotiation and a different link 
speed. So, the MDIO speed setting may require an adjustment. Even if it 
actually doesn't at the moment, doing the second call makes the code 
robust to future software and hardware changes.

--
Cyril
