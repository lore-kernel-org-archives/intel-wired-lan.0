From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 17 Mar 2022 09:11:04 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: Fix hang during reboot/shutdown
In-Reply-To: <20220317104524.2802848-1-ivecera@redhat.com>
References: <20220317104524.2802848-1-ivecera@redhat.com>
Message-ID: <20220317091104.1d911864@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 17 Mar 2022 11:45:24 +0100 Ivan Vecera wrote:
> Recent commit 974578017fc1 ("iavf: Add waiting so the port is
> initialized in remove") adds a wait-loop at the beginning of
> iavf_remove() to ensure that port initialization is finished
> prior unregistering net device. This causes a regression
> in reboot/shutdown scenario because in this case callback
> iavf_shutdown() is called and this callback detaches the device,
> makes it down if it is running and sets its state to __IAVF_REMOVE.
> Later shutdown callback of associated PF driver (e.g. ice_shutdown)
> is called. That callback calls among other things sriov_disable()
> that calls indirectly iavf_remove() (see stack trace below).
> As the adapter state is already __IAVF_REMOVE then the mentioned
> loop is end-less and shutdown process hangs.

Tony, Jesse, looks like the regression is from 5.17-rc6, should 
I take this directly so it makes 5.17 final?
