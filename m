From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 28 Jul 2020 20:34:41 +0000
Subject: [Intel-wired-lan] [v4][PATCH] e1000e: continue to init phy even
 when failed to disable ULP
In-Reply-To: <20200618065453.12140-1-aaron.ma@canonical.com>
References: <20200616100512.22512-1-aaron.ma@canonical.com>
 <20200618065453.12140-1-aaron.ma@canonical.com>
Message-ID: <DM6PR11MB2890F94DA893CE56A5D8A3EABC730@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Aaron Ma
> Sent: Wednesday, June 17, 2020 11:55 PM
> To: kuba at kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> davem at davemloft.net; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Lifshits, Vitaly
> <vitaly.lifshits@intel.com>; kai.heng.feng at canonical.com; Neftin, Sasha
> <sasha.neftin@intel.com>
> Subject: [Intel-wired-lan] [v4][PATCH] e1000e: continue to init phy even when
> failed to disable ULP
> 
> After 'commit e086ba2fccda4 ("e1000e: disable s0ix entry and exit flows
>  for ME systems")',
> ThinkPad P14s always failed to disable ULP by ME.
> 'commit 0c80cdbf3320 ("e1000e: Warn if disabling ULP failed")'
> break out of init phy:
> 
> error log:
> [   42.364753] e1000e 0000:00:1f.6 enp0s31f6: Failed to disable ULP
> [   42.524626] e1000e 0000:00:1f.6 enp0s31f6: PHY Wakeup cause - Unicast
> Packet
> [   42.822476] e1000e 0000:00:1f.6 enp0s31f6: Hardware Error
> 
> When disable s0ix, E1000_FWSM_ULP_CFG_DONE will never be 1.
> If continue to init phy like before, it can work as before.
> iperf test result good too.
> 
> Fixes: 0c80cdbf3320 ("e1000e: Warn if disabling ULP failed")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 1 -
>  1 file changed, 1 deletion(-)

I never did find a system that triggered the initial problem, but from a compatibility with the set of systems I do have working...
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
