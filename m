From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 15 Feb 2019 20:37:35 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Disable runtime PM on CNP+
In-Reply-To: <20190202174016.28539-1-kai.heng.feng@canonical.com>
References: <20190202174016.28539-1-kai.heng.feng@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96641B63@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Kai-Heng Feng
> Sent: Saturday, February 2, 2019 9:40 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] e1000e: Disable runtime PM on CNP+
> 
> There are some new e1000e devices can only be woken up from D3 one
> time,
> by plugging ethernet cable. Subsequent cable plugging does set PME bit
> correctly, but it still doesn't get woken up.
> 
> Since e1000e connects to the root complex directly, we rely on ACPI to
> wake it up. In this case, the GPE from _PRW only works once and stops
> working after that. Though it appears to be a platform bug, e1000e
> maintainers confirmed that I219 does not support D3.
> 
> So disable runtime PM on CNP+ chips. We may need to disable earlier
> generations if this bug also hit older platforms.
> 
> Bugzilla: https://bugzilla.kernel.org/attachment.cgi?id=280819
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
