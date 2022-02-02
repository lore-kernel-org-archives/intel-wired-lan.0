From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 1 Feb 2022 20:58:18 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <20220202044603.tuchbk72iujdyxi4@sx1>
References: <20220131172450.4905-1-saeed@kernel.org>
 <20220131095905.08722670@hermes.local>
 <CAMuHMdU17cBzivFm9q-VwF9EG5MX75Qct=is=F2h+Kc+VddZ4g@mail.gmail.com>
 <20220131183540.6ekn3z7tudy5ocdl@sx1>
 <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
 <20220131121027.4fe3e8dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7dc930c6-4ffc-0dd0-8385-d7956e7d16ff@gmail.com>
 <20220131151315.4ec5f2d3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <dd1497ca-b1da-311a-e5fc-7c7265eb3ddf@gmail.com>
 <20220202044603.tuchbk72iujdyxi4@sx1>
Message-ID: <20220201205818.2f28cfe5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 1 Feb 2022 20:46:03 -0800 Saeed Mahameed wrote:
> I am getting mixed messages here, on one hand we know that this patch
> might break some old or def configs, but on the other hand people claim
> that they have to manually fixup their own configs every time 
> "something in configs" changes and they are fine with that. 
> 
> Obviously I belong to the 2nd camp, hence this patch..
> 
> I can sum it up with "it's fine to controllably break *some* .configs for 
> the greater good" .. that's my .2cent.

I think we agree that we don't care about oldconfigs IOW someone's
random config.

But we do care about defconfigs in the tree, if those indeed include
ethernet drivers which would get masked out by vendor=n - they need
fixin':

$ find arch/ | grep defconfig
arch/x86/configs/i386_defconfig
arch/x86/configs/x86_64_defconfig
arch/ia64/configs/generic_defconfig
arch/ia64/configs/gensparse_defconfig
...

First one from the top:

$ make O=build_tmp/ i386_defconfig
$ $EDITOR drivers/net/ethernet/intel/Kconfig
$ git diff
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 3facb55b7161..b9fdf2a835b0 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -5,7 +5,6 @@
 
 config NET_VENDOR_INTEL
        bool "Intel devices"
-       default y
        help
          If you have a network (Ethernet) card belonging to this class, say Y.
 
$ make O=build_tmp/ i386_defconfig
$ diff -urpb build_tmp/.config.old build_tmp/.config
--- build_tmp/.config.old	2022-02-01 20:55:37.087373905 -0800
+++ build_tmp/.config	2022-02-01 20:56:32.126044628 -0800
@@ -1784,22 +1784,7 @@ CONFIG_NET_VENDOR_GOOGLE=y
 # CONFIG_GVE is not set
 CONFIG_NET_VENDOR_HUAWEI=y
 # CONFIG_HINIC is not set
-CONFIG_NET_VENDOR_I825XX=y
-CONFIG_NET_VENDOR_INTEL=y
-CONFIG_E100=y
-CONFIG_E1000=y
-CONFIG_E1000E=y
-CONFIG_E1000E_HWTS=y
-# CONFIG_IGB is not set
-# CONFIG_IGBVF is not set
-# CONFIG_IXGB is not set
-# CONFIG_IXGBE is not set
-# CONFIG_IXGBEVF is not set
-# CONFIG_I40E is not set
-# CONFIG_I40EVF is not set
-# CONFIG_ICE is not set
-# CONFIG_FM10K is not set
-# CONFIG_IGC is not set
+# CONFIG_NET_VENDOR_INTEL is not set
 CONFIG_NET_VENDOR_MICROSOFT=y
 # CONFIG_JME is not set
 CONFIG_NET_VENDOR_LITEX=y
