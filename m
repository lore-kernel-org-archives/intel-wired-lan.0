From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 18 Jan 2018 14:17:52 -0800
Subject: [Intel-wired-lan] Missing device ids in e100.c?
In-Reply-To: <d1ee433614608c72175747c2767bf20a.squirrel@mx.sdf.org>
References: <d1ee433614608c72175747c2767bf20a.squirrel@mx.sdf.org>
Message-ID: <20180118141752.00007188@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 17 Jan 2018 23:45:47 +0000 <sethsimon@sdf.org> wrote:

> Hi,
> I think I found an oversight in e100.c: The DOS packet driver
> based on the same chipset includes 3 additional PCI device ids
> (1035, 1036, and 1037 (all ICH 3)) that aren't in e100.c. See
> il.asm:207 in http://www.crynwr.com/drivers/e100b11b.zip.

Hi, thanks for your feedback. I investigated a bit for you.

I don't think the e100.c driver will support these without being
changed in the actual code.  They are all for the Home PNA (Phoneline
Network Adapter) products which are all end of life (not maintained or
sold).

1035 is the 82562EH based Phoneline Network Connection
1036 is the 82562EH based Phoneline Network Connection
1037 is also from the 82562 family

I recommend you don't worry about the missing IDs, unless you actually
have one of these devices and can get it to work (yourself) with the
e100.c driver, then we would review your patch.

Sorry to not be more help, but we generally don't do any development on
end of lifed products.

Jesse
