From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 28 Jan 2019 13:22:43 -0800
Subject: [Intel-wired-lan] ixgbe driver to provide tempeture info
 through hwmon?
In-Reply-To: <d91e7a2f-dbcb-288f-a04a-3e096ae01ac0@gmail.com>
References: <d91e7a2f-dbcb-288f-a04a-3e096ae01ac0@gmail.com>
Message-ID: <f15ef8cf07f50a70b0a991c58f3b17334767b488.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-01-23 at 16:06 +0100, Mikko Laaksonen wrote:
> Dears,
> A Mr. Lyson?k from Red Hat suggested I write to you. I understand
> that the X550-T2 has temperature sensors and a way of getting that
> data out of it. I don't understand how to get that data to
> lm_sensors, but Mr. Lyson?k suggests that the ixgbe maintainer could
> see if the temperature info can be gotten out to hwmon, after which
> he could see about making sensors-detect detect it.
> Any ideas?

Our current driver does not have the ability to have hwmon retrieve the
temperature sensor data currently.  It would take some work to
implement such a feature, which we currently cannot commit to.  We do
welcome patches from the community if you are interested in
implementing it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190128/e2b06f51/attachment.asc>
