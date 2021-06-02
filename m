From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Wed, 02 Jun 2021 00:10:08 +0000
Subject: [Intel-wired-lan] [PATCH net-next] igb: Fix
 -Wunused-const-variable warning
In-Reply-To: <20210601140238.20712-1-yuehaibing@huawei.com>
References: <20210601140238.20712-1-yuehaibing@huawei.com>
Message-ID: <162259260814.22595.7166722857871359129.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue, 1 Jun 2021 22:02:38 +0800 you wrote:
> If CONFIG_IGB_HWMON is n, gcc warns:
> 
> drivers/net/ethernet/intel/igb/e1000_82575.c:2765:17:
>  warning: ?e1000_emc_therm_limit? defined but not used [-Wunused-const-variable=]
>  static const u8 e1000_emc_therm_limit[4] = {
>                  ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/igb/e1000_82575.c:2759:17:
>  warning: ?e1000_emc_temp_data? defined but not used [-Wunused-const-variable=]
>  static const u8 e1000_emc_temp_data[4] = {
>                  ^~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] igb: Fix -Wunused-const-variable warning
    https://git.kernel.org/netdev/net-next/c/0a206f9d9e23

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


