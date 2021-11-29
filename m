From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 29 Nov 2021 09:59:47 -0800
Subject: [Intel-wired-lan] [RFC PATCH 0/4] r8169: support dash
In-Reply-To: <20211129101315.16372-381-nic_swsd@realtek.com>
References: <20211129101315.16372-381-nic_swsd@realtek.com>
Message-ID: <20211129095947.547a765f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 29 Nov 2021 18:13:11 +0800 Hayes Wang wrote:
> These patches are used to support dash for RTL8111EP and
> RTL8111FP(RTL81117).

If I understand correctly DASH is a DMTF standard for remote control.

Since it's a standard I think we should have a common way of
configuring it across drivers. Is enable/disable the only configuration
that we will need?

We don't use sysfs too much these days, can we move the knob to
devlink, please? (If we only need an on/off switch generic devlink param
should be fine).
