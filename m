From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 24 Sep 2020 17:32:12 +0200
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Increase iteration on
 polling MDIC ready bit
In-Reply-To: <20200924150958.18016-1-kai.heng.feng@canonical.com>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <20200924150958.18016-1-kai.heng.feng@canonical.com>
Message-ID: <748efbf9-573f-ab2a-0c82-a7b2a11cda60@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Kai-Heng,


Thank you for sending version 2.

Am 24.09.20 um 17:09 schrieb Kai-Heng Feng:
> We are seeing the following error after S3 resume:

I?d be great if you added the system and used hardware, you are seeing 
this with.

> [  704.746874] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.844232] e1000e 0000:00:1f.6 eno1: MDI Write did not complete

A follow-up patch, should extend the message to include the timeout value.

 > MDI Write did not complete did not complete in ? seconds.

According to the Linux timestamps it?s 98 ms, which makes sense, as (640 
* 3 * 50 ?s = 96 ms).

What crappy hardware is this, that it takes longer than 100 ms?

> [  704.902817] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.903075] e1000e 0000:00:1f.6 eno1: reading PHY page 769 (or 0x6020 shifted) reg 0x17
> [  704.903281] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
> [  704.903486] e1000e 0000:00:1f.6 eno1: writing PHY page 769 (or 0x6020 shifted) reg 0x17
> [  704.943155] e1000e 0000:00:1f.6 eno1: MDI Error
> ...
> [  705.108161] e1000e 0000:00:1f.6 eno1: Hardware Error
> 
> As Andrew Lunn pointed out, MDIO has nothing to do with phy, and indeed
> increase polling iteration can resolve the issue.

Please explicitly state, what the current timeout value is, and what it 
is increased to.

     640 * 3 * 50 ?s = 96 ms
     640 * 10 * 50 ?s = 320 ms

The macro definition also misses the unit.

     /* SerDes Control */
     #define E1000_GEN_POLL_TIMEOUT          640

How did you determine, that tenfold that value is good. And not 
eightfold, for example? Please give the exact value (Linux log message 
timestamps should be enough), what the hardware needs now.

As a commit message summary, I suggest:

 > e1000e: Increase MDIC ready bit polling timeout from 96 ms to 320 ms

> While at it, also move the delay to the end of loop, to potentially save
> 50 us.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>   - Increase polling iteration instead of powering down the phy.
> 
>   drivers/net/ethernet/intel/e1000e/phy.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> index e11c877595fb..72968a01164b 100644
> --- a/drivers/net/ethernet/intel/e1000e/phy.c
> +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> @@ -203,11 +203,12 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
>   	 * Increasing the time out as testing showed failures with
>   	 * the lower time out
>   	 */
> -	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
> -		udelay(50);
> +	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 10); i++) {
>   		mdic = er32(MDIC);
>   		if (mdic & E1000_MDIC_READY)
>   			break;
> +
> +		udelay(50);
>   	}
>   	if (!(mdic & E1000_MDIC_READY)) {
>   		e_dbg("MDI Write did not complete\n");
> 
