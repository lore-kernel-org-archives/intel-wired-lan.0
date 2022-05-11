From: lixue liang <lixue.liang5086@gmail.com>
Date: Wed, 11 May 2022 14:26:45 +0800
Subject: [Intel-wired-lan] [PATCH] igb_ethtool: fix efficiency issues in
 igb_set_eeprom
In-Reply-To: <7963e252-05cb-349e-5902-c4e38f7e9405@intel.com>
References: <20220510012159.8924-1-lianglixue@greatwall.com.cn>
 <7963e252-05cb-349e-5902-c4e38f7e9405@intel.com>
Message-ID: <AD31AFC0-2621-4671-986A-8BCE2AA9F514@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thank you very much for replying to my question and for suggesting corrections.

Since the interface (igb_set_eeprom) for arbitrarily modifying the mac address is provided, 
it is equivalent to providing a way to modify the mac address arbitrarily and cause the igb 
driver to fail to load. Therefore, a way to restore a valid mac address should also be reserved, 
so as to prevent most users from being helpless in the case of an invalid mac address.

Except by using tools to flash the firmware or modify the igb driver to continue loading under 
an invalid mac address, however most users do not have this ability. In the case of invalidity, 
the invalid mac address must be changed to a legal address, so it is always better to use a 
valid mac address to continue pretending to be a network card driver when the mac address is invalid,
 which is always better than not being able to load the driver, such as the microchip network card (lan743x) driver .

I think it is worthwhile to replace the invalid mac address with a random valid mac address to 
complete the igb driver loading. In response to the above problem, I will provide a patch on igb_main.c again..

Thank you for taking the time.

> 2022?5?11? 03:43?Jesse Brandeburg <jesse.brandeburg@intel.com> ???
> 
> Please include netdev mailing list when mailing the maintainers of netdev.

