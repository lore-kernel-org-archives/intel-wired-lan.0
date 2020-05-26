From: Sasha Levin <sashal@kernel.org>
Date: Tue, 26 May 2020 00:23:55 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Do not wake up the system
 via WOL if device wakeup is disabled
In-Reply-To: <9f7ede2e2e8152704258fc11ba3755ae93f50741.1590081982.git.yu.c.chen@intel.com>
References: <9f7ede2e2e8152704258fc11ba3755ae93f50741.1590081982.git.yu.c.chen@intel.com>
Message-ID: <20200526002355.B2FAE20657@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)").

The bot has tested the following trees: v5.6.14, v5.4.42, v4.19.124, v4.14.181, v4.9.224, v4.4.224.

v5.6.14: Build OK!
v5.4.42: Build OK!
v4.19.124: Build OK!
v4.14.181: Build OK!
v4.9.224: Failed to apply! Possible dependencies:
    c8744f44aeae ("e1000e: Add Support for CannonLake")

v4.4.224: Failed to apply! Possible dependencies:
    16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt")
    18dd23920703 ("e1000e: use BIT() macro for bit defines")
    74f31299a41e ("e1000e: Increase PHY PLL clock gate timing")
    c8744f44aeae ("e1000e: Add Support for CannonLake")
    f3ed935de059 ("e1000e: initial support for i219-LM (3)")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
