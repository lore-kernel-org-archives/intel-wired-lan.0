From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Date: Mon, 25 Apr 2016 18:00:45 +0200
Subject: [Intel-wired-lan] issue with kernel patch
	2a3cdead8b408351fa1e3079b220fa331480ffbc
In-Reply-To: <1768814989.41697.1461598056358.JavaMail.zimbra@xes-inc.com>
References: <1461577586.24438.14.camel@maxwell>
 <9BBC4E0CF881AA4299206E2E1412B626501BC575@ORSMSX102.amr.corp.intel.com>
 <9B4A1B1917080E46B64F07F2989DADD65ABFD85F@ORSMSX114.amr.corp.intel.com>
 <1768814989.41697.1461598056358.JavaMail.zimbra@xes-inc.com>
Message-ID: <1461600045.21920.10.camel@maxwell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Aaron,

On Mo, 2016-04-25 at 10:27 -0500, Aaron Sierra wrote:
> Jochen,
> I have similar hardware to you. What PHY ID are you finding?

The chip is WTI210IT from Intel, I am currently not in the office but I
will provide the PHY ID tomorrow. However, the chip datasheet
(http://www.intel.de/content/dam/www/public/us/en/documents/datasheets/i210-ethernet-controller-datasheet.pdf)
8.27.3.3/8.27.3.4 says that the PHY IDs are fixed (RO), but the values
read from the chip are different from what is defined in the datasheet
and I wonder if this is related to the modified register read/write
after the patch.
However, the patch works fine with the BYT embedded network controller.

Jochen

> 
> -Aaron
> 

-- 
Henneberg - Systemdesign
Jochen Henneberg
Loehnfeld 26
21423 Winsen (Luhe)
--
Fon: +49 4174 668 773
Mobile: +49 172 160 14 69
Fax: +49 321 210 761 64
www: www.henneberg-systemdesign.com



