From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 15 Feb 2021 11:05:17 +0100
Subject: [Intel-wired-lan] [PATCH next-queue v1 2/2] igc: enable
 auxiliary PHC functions for the i225
In-Reply-To: <20210212014212.41570-3-ederson.desouza@intel.com>
References: <20210212014212.41570-1-ederson.desouza@intel.com>
 <20210212014212.41570-3-ederson.desouza@intel.com>
Message-ID: <bd0bfa55-de44-82e9-337a-e6254d3a8405@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Ederson,


Am 12.02.21 um 02:42 schrieb Ederson de Souza:
> The i225 device offers a number of special PTP Hardware Clock features on
> the Software Defined Pins (SDPs). This patch adds support for two of the
> possible functions, namely time stamping external events, and periodic
> output signals.
> 
> The assignment of PHC functions to the four SDP can be freely chosen by
> the user.
> 
> While i225 allows up to four timers to be used to source the time used
> on the external events or output signals, this patch uses only one of
> those timers.

Why is that? Because it?s simpler to implement? Please add the reason to 
the commit message.

It?d be also great, if you mentioned the datasheet name and revision 
used for implementing this.


Kind regards,

Paul
