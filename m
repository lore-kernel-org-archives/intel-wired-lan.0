From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 10 Mar 2022 13:59:01 -0800
Subject: [Intel-wired-lan] [PATCH net] ice: Fix race condition during
 interface enslave
In-Reply-To: <20220310171641.3863659-1-ivecera@redhat.com>
References: <20220310171641.3863659-1-ivecera@redhat.com>
Message-ID: <20220310135901.39b1abdf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 10 Mar 2022 18:16:41 +0100 Ivan Vecera wrote:
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
> ip link add lag0 type bond mode 1 miimon 100
> ip link set lag0
> 
> for n in {1..10}; do
>         echo Cycle: $n
>         ip link set ens7f0 master lag0
>         sleep 1
>         ip link set ens7f0 nomaster
> done

What's the priority on this one? The loop max of 10 seems a little
worrying.

Tony, Jesse, is it important enough to push into 5.17 or do you prefer
to take it via the normal path and do full QA? The blamed patch come
in to 5.17-rc it seems.
