From: Felicitas Hetzelt <felicitashetzelt@gmail.com>
Date: Thu, 2 Sep 2021 14:15:04 +0200
Subject: [Intel-wired-lan] Potential oob access in e100.c:get_regs(_len)
Message-ID: <1f52bd29-43e7-0639-57cf-abfb7dc9804b@sect.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I think there might be a bug in the get_regs ethtool ioctl in e100.c. It
seems pretty obvious to me, so I wonder if I'm thinking wrong but:

here the size of the regs array is set:

https://github.com/torvalds/linux/blob/4ac6d90867a4de2e12117e755dbd76e08d88697f/drivers/net/ethernet/intel/e100.c#L2444

which is used to allocate an array to store the regdata:

https://github.com/linuxkit/linux/blob/ccda4af0f4b92f7b4c308d3acc262f4a7e3affad/net/core/ethtool.c#L1339

The size of the allocated buffer would be: *1* + E100_PHY_REGS +
sizeof(nic->mem->dump_buf);

Then the reg data is copied, but the copied size is *2* + E100_PHY_REGS
+ sizeof(nic->mem->dump_buf), no?

https://github.com/torvalds/linux/blob/4ac6d90867a4de2e12117e755dbd76e08d88697f/drivers/net/ethernet/intel/e100.c#L2464


Regards,

Felicitas


