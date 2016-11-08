From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Tue, 8 Nov 2016 17:54:26 +0000
Subject: [Intel-wired-lan] I am looking for a specific driver - 3.4.8-k
In-Reply-To: <1478627090.2341.8.camel@intel.com>
References: <OFBF794E37.EA201181-ON86258065.0050FFD1-86258065.0051242C@graco.com>
 <1478627090.2341.8.camel@intel.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664696B0DB64@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, November 08, 2016 9:45 AM
> To: SKahn at graco.com; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] I am looking for a specific driver - 3.4.8-k
> 
> On Tue, 2016-11-08 at 08:46 -0600, SKahn at graco.com wrote:
> > I am trying to locate a driver for X520 Dual Port 10 G Ethernet PICe
> > Adapter, this version specifically - Manufacturer = Intel Adapter
> > Driver = 3.4.8-k .
> >
> > This is for a Cisco UCSC system with RedHat Linux 5.8 64 bit
> 
> You should be able to find the version of ixgbe driver you are looking for on
> e1000.sf.net.

Also the "-k" at the end of the version means the driver is an in-kernel driver.  This is further complicated by how RedHat can backport patches into its driver without it reflecting in the driver version number.  So why you can go to source forge to get a similarly versioned driver and it should be close it however will not be exactly the same as was in RedHat Linux 5.8.  It will contain kcompat code and not contain patches than may have be back ported by RedHat, along with other possible differences.  These might not be that important by I thought I would mention it.

Thanks,
-Don <donald.c.skidmore@intel.com>

