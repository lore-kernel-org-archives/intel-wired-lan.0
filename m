From: Aaron Ma <aaron.ma@canonical.com>
Date: Mon, 5 Jul 2021 15:38:29 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] igc: wait for the MAC copy when
 enabled MAC passthrough
In-Reply-To: <613e2106-940a-49ed-6621-0bb00bc7dca5@intel.com>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
 <20210702045120.22855-2-aaron.ma@canonical.com>
 <613e2106-940a-49ed-6621-0bb00bc7dca5@intel.com>
Message-ID: <ad3d2d01-1d0a-8887-b057-e6a9531a05f4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 7/4/21 1:36 PM, Neftin, Sasha wrote:
> On 7/2/2021 07:51, Aaron Ma wrote:
>> Such as dock hot plug event when runtime, for hardware implementation,
>> the MAC copy takes less than one second when BIOS enabled MAC passthrough.
>> After test on Lenovo TBT4 dock, 600ms is enough to update the
>> MAC address.
>> Otherwise ethernet fails to work.
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>> ? 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 606b72cb6193..c8bc5f089255 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -5468,6 +5468,9 @@ static int igc_probe(struct pci_dev *pdev,
>> ????? memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
>> ????? memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
>> +??? if (pci_is_thunderbolt_attached(pdev) > +??????? msleep(600);
> I believe it is a bit fragile. I would recommend here look for another indication instead of delay. Can we poll for a 'pci_channel_io_normal' state? (igc->pdev->error_state == pci_channel_io_normal)

Hi sasha,
In this situation, the error_state is always pci_channel_io_normal.
The delay is necessary.

Refer to "627239-Intel? Ethernet Controller I225-MAC-Address-Passthrough-rev1.2"
section "3.5
  Timing Considerations":
"For hardware implementation,

when the operating system is already running, the MAC copy must happen not more than one

second after TBT link is established.
the I225 Windows driver prevents the operating

system from detecting the I225 for one second. This allows enough time for hardware to update the

MAC address."

Thanks sasha,
Aaron

>> +
>> ????? /* Initialize skew-specific constants */
>> ????? err = ei->get_invariants(hw);
>> ????? if (err)
>>
> Thanks Aaron,
> sasha
