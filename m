From: Tal Gilboa <talgi@mellanox.com>
Date: Wed, 8 Aug 2018 17:23:12 +0300
Subject: [Intel-wired-lan] [PATCH v6 8/9] net/mlx5: Do not call
 pcie_print_link_status()
In-Reply-To: <20180808060848.GQ13378@mtr-leonro.mtl.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-8-mr.nuke.me@gmail.com>
 <20180808060848.GQ13378@mtr-leonro.mtl.com>
Message-ID: <05056a70-ee78-ea3c-0b9b-6d64a8663b11@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/8/2018 9:08 AM, Leon Romanovsky wrote:
> On Mon, Aug 06, 2018 at 06:25:42PM -0500, Alexandru Gagniuc wrote:
>> This is now done by the PCI core to warn of sub-optimal bandwidth.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> 

Alex,
I loaded mlx5 driver with and without these series. The report in dmesg 
is now missing. From what I understood, the status should be reported at 
least once, even if everything is in order. We need this functionality 
to stay.

net-next (dmesg output for 07:00.0):
[270498.625351] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
[270498.632130] mlx5_core 0000:07:00.0: 63.008 Gb/s available PCIe 
bandwidth (8 GT/s x8 link)
[270499.169533] (0000:07:00.0): E-Switch: Total vports 9, per vport: max 
uc(1024) max mc(16384)
[270499.182358] mlx5_core 0000:07:00.0: Port module event: module 0, 
Cable plugged

net-next + patches (dmesg output for 07:00.0):
[  331.608472] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
[  332.564938] (0000:07:00.0): E-Switch: Total vports 9, per vport: max 
uc(1024) max mc(16384)
[  332.616271] mlx5_core 0000:07:00.0: Port module event: module 0, 
Cable plugged


