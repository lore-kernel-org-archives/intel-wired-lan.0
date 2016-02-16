From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 16 Feb 2016 23:47:25 +0100
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V2
In-Reply-To: <255BB17A-515B-467A-8ED6-96F1173D233E@gmail.com>
References: <56BFA87D.1010609@gmail.com> <20160216165850.GF29482@lunn.ch>
 <255BB17A-515B-467A-8ED6-96F1173D233E@gmail.com>
Message-ID: <20160216224725.GC6033@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> I can supply some kind of usage description/example, showing how to
> use this feature to pull in the MAC address from u-boot and route it
> to the i210. Just uncertain as how to name the respective
> file. igb.txt or i210.txt come to mind. Do you prefer one over the
> other?

Hi John

It is quite common to name it after the compatible string, so
intel,i210.txt

Thanks
	Andrew
