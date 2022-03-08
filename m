From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 8 Mar 2022 19:34:48 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix BUG: scheduling while
 atomic: kworker/u64:0/9/0x00000002
In-Reply-To: <Yid7HCwekP1IsMN3@calimero.vinschen.de>
References: <20220308092422.2971655-1-sasha.neftin@intel.com>
 <Yid7HCwekP1IsMN3@calimero.vinschen.de>
Message-ID: <4485d49c-7051-97d2-d5a7-0729e68ce7a7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/8/2022 17:49, Corinna Vinschen wrote:
> Hi Sasha,
> 
> On Mar  8 11:24, Sasha Neftin wrote:
>> Replace usleep_range() method with udelay() method to allow atomic contects
>> in low-level MDIO access functions.
> 
> The commit message is a bit on the short end.  It should probably quote
> the reproducer from the below Bugzilla, rather than just pointing to the
> Bugzilla, i.e.,
Thanks Corinna and Maciej - I will resend v2.
> 
> $ modprobe -r bonding
> $ modprobe -v bonding max_bonds=1 mode=1 miimon=100 use_carrier=0
> $ ip link set bond0 up
> $ ifenslave bond0 eth0 eth1
> 
> leads to the following [shortened] kernel log:
> 
> [  120.198086] Voluntary context switch within RCU read-side critical section!
> [  120.198093] WARNING: CPU: 3 PID: 10 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x4ea/0x580
> [  120.207310] bond0: (slave ens5f0): Enslaving as a backup interface with a down link
> [  120.229488] [...]
> [  120.754723] Workqueue: bond0 bond_mii_monitor [bonding]
> [  120.779106] RIP: 0010:rcu_note_context_switch+0x4ea/0x580
> [  120.803880] Code: 08 49 89 8e 40 08 00 00 4d 89 be 48 08 00 00 4d 89 07 e9 98 fe ff ff 48 c7 c7 48 83 94 b6 c6 05 74 3b e1 01 01 e8 35 fd 8a 00 <0f> 0b e9 67 fb ff ff 45 85 f6 0f 84 9e fe ff ff 4c 89 85 a8 00 00
> [  120.890778] RSP: 0018:ffffa2f5c01bbbc8 EFLAGS: 00010082
> [  120.915218] RAX: 0000000000000000 RBX: ffff938d6f8f1740 RCX: 0000000000000027
> [  120.948713] RDX: 0000000000000027 RSI: ffff938d6f8dfcc0 RDI: ffff938d6f8dfcc8
> [  120.982368] RBP: ffffa2f5c01bbc50 R08: 0000000000000000 R09: c0000000ffff7fff
> [  121.016065] R10: 0000000000000001 R11: ffffa2f5c01bb9e0 R12: ffff938a022a9980
> [  121.049504] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> [  121.082870] FS:  0000000000000000(0000) GS:ffff938d6f8c0000(0000) knlGS:0000000000000000
> [  121.121993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  121.151532] CR2: 0000556901ea4f28 CR3: 0000000482810001 CR4: 00000000001706e0
> [  121.186337] Call Trace:
> [  121.197543]  <TASK>
> [  121.207444]  __schedule+0x9a/0x7b0
> [  121.223316]  ? hrtimer_start_range_ns+0x11d/0x300
> [  121.245293]  schedule+0x41/0xc0
> [  121.259860]  schedule_hrtimeout_range_clock+0x83/0x100
> [  121.283548]  ? hrtimer_init_sleeper+0x80/0x80
> [  121.303830]  usleep_range_state+0x5b/0x80
> [  121.322747]  igc_read_phy_reg_gpy+0x90/0x180 [igc]
> [  121.345249]  igc_phy_has_link+0x7d/0x170 [igc]
> [  121.365980]  igc_check_for_copper_link+0x60/0xd0 [igc]
> [  121.390260]  igc_has_link+0x2a/0x80 [igc]
> [  121.409093]  igc_ethtool_get_link+0x24/0x30 [igc]
> [  121.431248]  bond_check_dev_link.isra.49+0x5a/0x120 [bonding]
> [  121.458271]  ? pick_next_task_fair+0x3e/0x3b0
> [  121.478749]  ? put_prev_entity+0x22/0xe0
> [  121.497154]  ? put_prev_task_fair+0x1b/0x30
> [  121.516903]  bond_mii_monitor+0x107/0x540 [bonding]
> [...]
> 
>> Fixes: 5586838fe9ce ("igc: Add code for PHY support")
>> Reported-by: Corinna Vinschen <vinschen@redhat.com>
>> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_phy.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
>> index 40dbf4b43234..6961f65d36b9 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
>> @@ -581,7 +581,7 @@ static s32 igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data)
>>   	 * the lower time out
>>   	 */
>>   	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
>> -		usleep_range(500, 1000);
>> +		udelay(50);
>>   		mdic = rd32(IGC_MDIC);
>>   		if (mdic & IGC_MDIC_READY)
>>   			break;
>> @@ -638,7 +638,7 @@ static s32 igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data)
>>   	 * the lower time out
>>   	 */
>>   	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
>> -		usleep_range(500, 1000);
>> +		udelay(50);
>>   		mdic = rd32(IGC_MDIC);
>>   		if (mdic & IGC_MDIC_READY)
>>   			break;
>> -- 
>> 2.30.2
> 
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> 
> 
> Thanks,
> Corinna
> 

