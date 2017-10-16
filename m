From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 15 Oct 2017 17:14:37 -0700
Subject: [Intel-wired-lan] IPSec offload - ixgbe/i40e ..
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA361013EA800@FRAEML521-MBS.china.huawei.com>
References: <B84047ECBD981D4B93EAE5A6245AA361013EA800@FRAEML521-MBS.china.huawei.com>
Message-ID: <CAKgT0UdAY+c+GPOuUtk0s_Os+JY5nPRWxSmZS3vswcJbWncPfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Oct 15, 2017 at 8:12 AM, Avi Cohen (A) <avi.cohen@huawei.com> wrote:
> Hi,
> These Intel  NIC's:  X540, 82599, I40E - supports IPsec offload

X540 and 82599 are Ethernet Silicon, but i40e is just a driver. I
assume you mean X710 or one of the parts in that product family. Last
I knew the X710 and XL710 do not support ipsec, only the 82599 and
X540.

> But I don't see that the drivers  supplied by Intel - handle it (??)
> Can someone tell if this is supported somewhere ?
> Best Regards
> Avi

As far as I am aware there aren't currently any drivers available for
Linux that support ipsec offload on the X540 or 82599.

- Alex
