From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 17 Jun 2020 09:28:54 -0700
Subject: [Intel-wired-lan] [v2][PATCH] e1000e: continue to init phy even
 when failed to disable ULP
In-Reply-To: <20200617111249.20855-1-aaron.ma@canonical.com>
References: <20200616100512.22512-1-aaron.ma@canonical.com>
 <20200617111249.20855-1-aaron.ma@canonical.com>
Message-ID: <20200617092854.7be16376@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 17 Jun 2020 19:12:48 +0800 Aaron Ma wrote:
> After commit: e086ba2fccd ("e1000e: disable s0ix entry and exit flows
>  for ME systems").
> ThinkPad P14s always failed to disable ULP by ME.
> commit: 0c80cdbf33 ("e1000e: Warn if disabling ULP failed")
> break out of init phy:
> 
> error log:
> [   42.364753] e1000e 0000:00:1f.6 enp0s31f6: Failed to disable ULP
> [   42.524626] e1000e 0000:00:1f.6 enp0s31f6: PHY Wakeup cause - Unicast Packet
> [   42.822476] e1000e 0000:00:1f.6 enp0s31f6: Hardware Error
> 
> When disable s0ix, E1000_FWSM_ULP_CFG_DONE will never be 1.
> If continue to init phy like before, it can work as before.
> iperf test result good too.
> 
> Fixes: 0c80cdbf33 ("e1000e: Warn if disabling ULP failed")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Fixes tag: Fixes: 0c80cdbf33 ("e1000e: Warn if disabling ULP failed")
Has these problem(s):
	- SHA1 should be at least 12 digits long
	  Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
	  or later) just making sure it is not set (or set to "auto").
