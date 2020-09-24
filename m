From: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
Date: Thu, 24 Sep 2020 06:05:28 +0000
Subject: [Intel-wired-lan] General question regarding i40e driver version in
 upstream kernel
Message-ID: <33cb749a85e28598dd19e5041d896775b58fb0e1.camel@harmonicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi All,

I have a general question related to i40e driver in Linux kernel.
In latest Ubuntu-20.04 release (Focal) with kernel 5.4.0-42-generic the standard i40e driver is quite old (2.8.20-k),
while on Intel official site recently was announced newer i40e (2.12.6).
Also, the latest upstream kernel is 5.8.3 has the same (2.8.20-k) version of i40e driver.
See here: https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/intel/i40e/i40e_main.c#L28

Could, anybody from driver maintainers, clarify why there is such a big gap in versions of i40e driver.
Do all the drivers, from 2.8.20-k version, not stable enough, so they were not taken into kernel upstream?

-- 
Best regards,
Arkady Gilinsky

------------------------------------------

