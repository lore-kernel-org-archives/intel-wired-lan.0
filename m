From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 16 Mar 2016 10:21:03 -0700
Subject: [Intel-wired-lan] Latest dev-queue pull has i40e VFs reporting
	"Device still in reset"
Message-ID: <CAKgT0Ue=36RUVBkDJ0scqCwFEph8JOJmBqaD2MiY+CDvj3mpuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

So my system with the latest pull of the dev-queue branch is stuck
reporting "Device is still in reset (-16), retrying" for one or more
VFs after I reload the drivers.  I've been trying to bisect the issue
but haven't been having much luck.

Just wanted to see if anyone in Intel was aware of the issue,
otherwise I will probably re-run my bisection with a full system reset
between patches as I suspect I may be having issues reproducing it due
to stray data being left in from earlier driver loads.

- Alex
