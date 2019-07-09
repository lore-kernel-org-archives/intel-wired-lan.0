From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2019 11:55:17 -0700
Subject: [Intel-wired-lan] WARNING in mark_chain_precision
In-Reply-To: <000000000000a94981058d37f1a4@google.com>
References: <CAEf4BzaUEWwGL3k0VeiFYFqyJexQU9cDZWN69jSDpBjP1ZEcpw@mail.gmail.com>
 <000000000000a94981058d37f1a4@google.com>
Message-ID: <CAEf4BzYTGuXgN+vNJEoMbH_GFAVnSsBvq_YhvoFOeGG5Y+N_ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Original reproducer is almost identical to the one that is fixed by
https://patchwork.ozlabs.org/patch/1129479/.

bpf_prog_free_deferred bug that's undeterministically exposed after
this fix seems to be the cause of a bunch of other bug reports and is
not related to verifier precision tracking.

#syz dup: WARNING in __mark_chain_precision
