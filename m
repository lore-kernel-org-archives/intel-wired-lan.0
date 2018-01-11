From: wangyunjian <wangyunjian@huawei.com>
Date: Thu, 11 Jan 2018 02:53:31 +0000
Subject: [Intel-wired-lan] 4.15.0-rc6 unable to handle kernel NULL
 pointer dereference in ixgbe_down
In-Reply-To: <87618083B2453E4A8714035B62D67992B40E45DD@FMSMSX105.amr.corp.intel.com>
References: <34EFBCA9F01B0748BEB6B629CE643AE60C7093CF@dggemm513-mbs.china.huawei.com>
 <87618083B2453E4A8714035B62D67992B40E45DD@FMSMSX105.amr.corp.intel.com>
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60C70D96E@dggemm513-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I excuted multiple script 1 and script 2 , and ran them for a long time .
The nic is Intel 82599. 

I think we should use a lock to protect adapter->vfinfo when disable sriov
and down nic.

> -----Original Message-----
> From: Tantilov, Emil S [mailto:emil.s.tantilov at intel.com]
> Sent: Wednesday, January 10, 2018 5:16 AM
> To: wangyunjian <wangyunjian@huawei.com>; netdev at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org
> Subject: RE: 4.15.0-rc6 unable to handle kernel NULL pointer dereference in
> ixgbe_down
> 
> >-----Original Message-----
> >From: netdev-owner at vger.kernel.org
> >[mailto:netdev-owner at vger.kernel.org]
> >On Behalf Of wangyunjian
> >Sent: Monday, January 08, 2018 1:31 AM
> >To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> >Subject: BUG: 4.15.0-rc6 unable to handle kernel NULL pointer
> >dereference in ixgbe_down
> >
> >Hi,
> >
> >I'm running into a NULL pointer dereference in ixgbe_down on
> >b84449dc14d274a3f3c78cd734b702ca31aa4dd1
> >git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master.
> >
> >I think the variable adapter->vfinfo has not been protected well, when
> >disable sriov and down nic.
> >Anyone has an idea to protect it?
> >
> >Test script 1:
> >while true
> >do
> >??? ifconfig eth3 up
> >??? ifconfig eth3 down
> >done
> >
> >Test script 2:
> >while true
> >do
> >??? echo 63 > /sys/class/net/eth3/device/sriov_numvfs
> >??? echo 0 > /sys/class/net/eth3/device/sriov_numvfs
> >done
> 
> I ran this test on my system and also forwarded this report to our validation
> but we were not able to hit this crash. Does it crash fairly quickly, or do you
> need to run it for some time.
> 
> In ixgbe_down() I can see where there may be races due to the adapter-
> >num_vfs check. Ideally we should probably move to adapter->vfinfo checks
> only, but it would be nice to have a way to reproduce it for the purpose of
> testing fixes and debugging in general. Could you provide your .config file and
> additional information about your system - architecture, NIC type etc.
> 
> Thanks,
> Emil

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ATT77341.config
Type: application/octet-stream
Size: 190834 bytes
Desc: ATT77341.config
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180111/1b094696/attachment-0001.obj>
