From: Avi Cohen (A) <avi.cohen@huawei.com>
Date: Mon, 16 Oct 2017 06:47:12 +0000
Subject: [Intel-wired-lan] IPSec offload - ixgbe/i40e ..
In-Reply-To: <CAKgT0UdAY+c+GPOuUtk0s_Os+JY5nPRWxSmZS3vswcJbWncPfA@mail.gmail.com>
References: <B84047ECBD981D4B93EAE5A6245AA361013EA800@FRAEML521-MBS.china.huawei.com>
 <CAKgT0UdAY+c+GPOuUtk0s_Os+JY5nPRWxSmZS3vswcJbWncPfA@mail.gmail.com>
Message-ID: <B84047ECBD981D4B93EAE5A6245AA361013ECAA8@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Monday, 16 October, 2017 3:15 AM
> To: Avi Cohen (A)
> Cc: intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] IPSec offload - ixgbe/i40e ..
> 
> On Sun, Oct 15, 2017 at 8:12 AM, Avi Cohen (A) <avi.cohen@huawei.com>
> wrote:
> > Hi,
> > These Intel  NIC's:  X540, 82599, I40E - supports IPsec offload
> 
> X540 and 82599 are Ethernet Silicon, but i40e is just a driver. I assume you
> mean X710 or one of the parts in that product family. Last I knew the X710 and
> XL710 do not support ipsec, only the 82599 and X540.
[Avi Cohen (A)] 
Yes Alex - I meant the X710 family
> 
> > But I don't see that the drivers  supplied by Intel - handle it (??)
> > Can someone tell if this is supported somewhere ?
> > Best Regards
> > Avi
> 
> As far as I am aware there aren't currently any drivers available for Linux that
> support ipsec offload on the X540 or 82599.
[Avi Cohen (A)] 
I saw that these drivers are called 'base drivers' - are there other 'enhanced' drivers for linux that do support the IPSec offload ?
Best Regards
Avi
> 
> - Alex
