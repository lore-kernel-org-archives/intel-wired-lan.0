From: Ido Schimmel <idosch@idosch.org>
Date: Tue, 21 Sep 2021 16:25:54 +0300
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: add support for
 reading SyncE DPLL state
In-Reply-To: <20210903151436.529478-3-maciej.machnikowski@intel.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-3-maciej.machnikowski@intel.com>
Message-ID: <YUndYq8EcpyPnPud@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 03, 2021 at 05:14:36PM +0200, Maciej Machnikowski wrote:
> Implement SyncE DPLL monitoring for E810-T devices.
> Poll loop will periodically check the state of the DPLL and cache it
> in the pf structure. State changes will be logged in the system log.
> 
> Cached state can be read using the RTM_GETEECSTATE rtnetlink
> message.

This seems sub-optimal. My understanding is that this information is of
importance to the user space process that takes care of the ESMC
protocol. It would probably want to receive a notification when the
state of the DPLL/EEC changes as opposed to polling the kernel or poking
into its log.

So I think that whatever netlink-based interface we agree on to
represent the EEC (devlink or something else), should have the ability
to send a notification when the state changes.
