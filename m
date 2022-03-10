From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 10 Mar 2022 23:30:10 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Fix race condition during
 interface enslave
In-Reply-To: <20220310171641.3863659-1-ivecera@redhat.com>
References: <20220310171641.3863659-1-ivecera@redhat.com>
Message-ID: <164695501044.21304.15926630200023275833.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Mar 2022 18:16:41 +0100 you wrote:
> Commit 5dbbbd01cbba83 ("ice: Avoid RTNL lock when re-creating
> auxiliary device") changes a process of re-creation of aux device
> so ice_plug_aux_dev() is called from ice_service_task() context.
> This unfortunately opens a race window that can result in dead-lock
> when interface has left LAG and immediately enters LAG again.
> 
> Reproducer:
> ```
> #!/bin/sh
> 
> [...]

Here is the summary with links:
  - [net] ice: Fix race condition during interface enslave
    https://git.kernel.org/netdev/net/c/5cb1ebdbc434

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


