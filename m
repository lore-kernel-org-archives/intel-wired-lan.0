From: Aaron Sierra <asierra@xes-inc.com>
Date: Thu, 1 Dec 2016 10:19:54 -0600 (CST)
Subject: [Intel-wired-lan] [PATCH] igb: reset the PHY before reading the
	PHY ID
In-Reply-To: <20161201031318.GA6368@outlook.office365.com>
References: <1589605144.308560.1480435436440.JavaMail.zimbra@xes-inc.com>
 <20161201031318.GA6368@outlook.office365.com>
Message-ID: <1279201741.206062.1480609194012.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

----- Original Message -----
> From: "Chris Arges" <carges@vectranetworks.com>
> Sent: Wednesday, November 30, 2016 9:13:18 PM
>
> Hi,
> I could not get this patch to fix the original issue I had.
> The patch I submitted a while back fixed the issue for me:
> https://patchwork.ozlabs.org/patch/690464/
> 
> Let me know if there is something else I can get check here. To reproduce
> I have to fully power off the server which contains this NIC.
> --chris
> 

Chris,
Can you provide any more information about your environment than you
already have? I've only found that you're using an I210. Is it embedded
in the baseboard or an add-in device? Please share very verbose lspci
output for this device:

    lspci -vvv -n -s <[bus]:[device].[function]>

What kernel version did you use in your testing? Did my patch apply
cleanly or with "fuzz" reported by the patch command?

-Aaron S.

