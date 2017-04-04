From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 4 Apr 2017 19:56:58 +0300
Subject: [Intel-wired-lan] [PATCH] i40e: limit client interface to X722
	hardware
In-Reply-To: <20170404143446.16359-1-sassmann@kpanic.de>
References: <20170404143446.16359-1-sassmann@kpanic.de>
Message-ID: <CAJ3xEMjvmXTAyLP2-BwHRj59uQeCNXA7XSX7kTA=8TmwwmzRkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Apr 4, 2017 at 5:34 PM, Stefan Assmann <sassmann@kpanic.de> wrote:
> The client interface is meant for X722 iWARP support. Modprobing i40iw
> on systems with X710/XL710 NICs currently may crash the system.

just curious may or crash? and why?
