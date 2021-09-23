From: Leon Romanovsky <leon@kernel.org>
Date: Fri, 24 Sep 2021 02:16:09 +0300
Subject: [Intel-wired-lan] [PATCH net-next 0/6] Batch of devlink related
 fixes
In-Reply-To: <20210923155547.248ab1aa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1632420430.git.leonro@nvidia.com>
 <20210923155547.248ab1aa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YU0KubuG03l8isms@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 23, 2021 at 03:55:47PM -0700, Jakub Kicinski wrote:
> On Thu, 23 Sep 2021 21:12:47 +0300 Leon Romanovsky wrote:
> > I'm asking to apply this batch of devlink fixes to net-next and not to
> > net, because most if not all fixes are for old code or/and can be considered
> > as cleanup.
> > 
> > It will cancel the need to deal with merge conflicts for my next devlink series :).
> 
> Not sure how Dave will feel about adding fixes to net-next,
> we do merge the trees weekly after all.

My almost ready submission queue is:
?  kernel git:(m/devlink) git l
693c1a9ac5b3 (HEAD -> m/devlink) devlink: Delete reload enable/disable interface
6d39354f8b44 net/mlx5: Register separate reload devlink ops for multiport device
1ac4e8811fd5 devlink: Allow set specific ops callbacks dynamically
de1849d3b348 devlink: Allow modification of devlink ops
7439a45dce72 net: dsa: Move devlink registration to be last devlink command
7dd23a327395 staging: qlge: Move devlink registration to be last devlink command
77f074c98b0d ptp: ocp: Move devlink registration to be last devlink command
fb3f4d40ad49 net: wwan: iosm: Move devlink_register to be last devlink command
87e95ee9275b netdevsim: Move devlink registration to be last devlink command
4173205af399 net: ethernet: ti: Move devlink registration to be last devlink command
bc633a0759f6 qed: Move devlink registration to be last devlink command
ead4e2027164 ionic: Move devlink registration to be last devlink command
bc5272ccc378 nfp: Move delink_register to be last command
a6521bf133d9 net: mscc: ocelot: delay devlink registration to the end
e0ca9a29cc20 mlxsw: core: Register devlink instance last
681ac1457516 net/mlx5: Accept devlink user input after driver initialization complete
9b1a2f4abaef net/mlx4: Move devlink_register to be the last initialization command
a3b2d9a95a51 net/prestera: Split devlink and traps registrations to separate routines
bbdf4842432f octeontx2: Move devlink registration to be last devlink command
5297e23f19e9 ice: Open devlink when device is ready
18af77a99cea net: hinic: Open device for the user access when it is ready
91a03cdc92e2 dpaa2-eth: Register devlink instance at the end of probe
dd5af984e53c liquidio: Overcome missing device lock protection in init/remove flows
efea109ba32e bnxt_en: Register devlink instance at the end devlink configuration
6a2b139bcf01 devlink: Notify users when objects are accessible

+ a couple of patches that removes "published" field from devlink parameters
and fix of old devlink bug where parameters were netlink notifications
were sent twice.

So it will be very helpful to keep this series in net-next.

> 
> Otherwise the patches look fine.

Thanks

